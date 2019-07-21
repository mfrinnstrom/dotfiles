#!/bin/bash

# Arch Bootstraping script
# License: GNU GPLv3
# Adapted from: https://github.com/ispanos/YARBS/blob/master/yarbs.sh
error() { clear; printf "ERROR:\\n%s\\n" "$1"; exit;}

aurhelper="yay"

baseUrl="https://raw.githubusercontent.com/mfrinnstrom/dotfiles/master/arch-linux"
coreprogs="$baseUrl/core.csv"
common="$baseUrl/common.csv"
sway="$baseUrl/sway.csv"

[ -z "$prog_files" ] && prog_files="$sway $coreprogs $common"

# Used in more that one place.
serviceinit() { 
	for service in "$@"; do
		dialog --infobox "Enabling \"$service\"..." 4 40
		systemctl enable "$service"
	done
}

get_dialog() {
	echo "Installing dialog, to make things look better..."
	pacman --noconfirm -Syyu dialog >/dev/null 2>&1
}

confirm_n_go() { dialog --title "Here we go" --yesno "Are you sure you wanna bootstra this computer?" 6 35 ; }

get_deps() {
	dialog --title "First things first." --infobox "Installing 'base-devel', 'git', and 'linux-headers'." 3 60
	pacman --noconfirm --needed -S linux-headers git base-devel >/dev/null 2>&1
}

get_microcode(){
	case $(lscpu | grep Vendor | awk '{print $3}') in
		"GenuineIntel") cpu="intel" ;;
		"AuthenticAMD") cpu="amd" 	;;
		*)				cpu="no" 	;;
	esac

	if [ $cpu != "no" ]; then
		dialog --infobox "Installing ${cpu} microcode." 3 31
		pacman --noconfirm --needed -S ${cpu}-ucode >/dev/null 2>&1
	fi
}

systemd_boot() {
	# Installs systemd-boot to the eps partition
	dialog --infobox "Setting-up systemd-boot" 0 0
	bootctl --path=/boot install
	 
	# Creates pacman hook to update systemd-boot after package upgrade.
	mkdir -p /etc/pacman.d/hooks
	cat > /etc/pacman.d/hooks/bootctl-update.hook <<-EOF
		[Trigger]
		Type = Package
		Operation = Upgrade
		Target = systemd
		
		[Action]
		Description = Updating systemd-boot
		When = PostTransaction
		Exec = /usr/bin/bootctl update
	EOF
	 
	# Creates loader.conf. Stored in files/ folder on repo.
	cat > /boot/loader/loader.conf <<-EOF
		default  arch
		console-mode max
		editor   no
	EOF
	
	# sets uuidroot as the UUID of the partition mounted at "/".
	uuidroot="UUID=$(lsblk --list -fs -o MOUNTPOINT,UUID | grep "^/ " | awk '{print $2}')"
	
	# Creates loader entry for root partition, using the "linux" kernel
						echo "title   Arch Linux"           >  /boot/loader/entries/arch.conf
						echo "linux   /vmlinuz-linux"       >> /boot/loader/entries/arch.conf
	[ $cpu = "no" ] || 	echo "initrd  /${cpu}-ucode.img"    >> /boot/loader/entries/arch.conf
						echo "initrd  /initramfs-linux.img" >> /boot/loader/entries/arch.conf
						echo "options root=${uuidroot} rw"  >> /boot/loader/entries/arch.conf
}

pacman_stuff() {
	dialog --infobox "Performance tweaks. (pacman/yay)" 0 0
	
	# Creates pacman hook to keep only the 3 latest versions of packages.
	cat > /etc/pacman.d/hooks/cleanup.hook <<-EOF
		[Trigger]
		Type = Package
		Operation = Remove
		Operation = Install
		Operation = Upgrade
		Target = *
		
		[Action]
		Description = Keeps only the latest 3 versions of packages
		When = PostTransaction
		Exec = /usr/bin/paccache -rk3
	EOF

	sed -i "s/-j2/-j$(nproc)/;s/^#MAKEFLAGS/MAKEFLAGS/" /etc/makepkg.conf
	grep "^Color" /etc/pacman.conf >/dev/null || sed -i "s/^#Color/Color/" /etc/pacman.conf
	grep "ILoveCandy" /etc/pacman.conf >/dev/null || sed -i "/#VerbosePkgLists/a ILoveCandy" /etc/pacman.conf
}

disable_beep() { 
	dialog --infobox "Disabling 'beep error' sound." 10 50
	echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
}

maininstall() { # Installs all needed programs from main repo.
	dialog --infobox "Installing \`$1\` ($n of $total). $1 $2" 5 70
	pacman --noconfirm --needed -S "$1" > /dev/null 2>&1
}

gitmakeinstall() {
	dir=$(mktemp -d)
	dialog  --infobox "Installing \`$(basename "$1")\` ($n of $total). $(basename "$1") $2" 5 70
	git clone --depth 1 "$1" "$dir" > /dev/null 2>&1
	cd "$dir" || exit
	make >/dev/null 2>&1
	make install >/dev/null 2>&1
	cd /tmp || return
}

aurinstall() {
	dialog  --infobox "Installing \`$1\` ($n of $total) from the AUR. $1 $2" 5 70
	echo "$aurinstalled" | grep "^$1$" > /dev/null 2>&1 && return
	sudo -u "$name" $aurhelper -S --noconfirm "$1" >/dev/null 2>&1
}

pipinstall() {
	dialog --infobox "Installing the Python package \`$1\` ($n of $total). $1 $2" 5 70
	command -v pip || pacman -S --noconfirm --needed python-pip >/dev/null 2>&1
	yes | pip install "$1"
}

mergeprogsfiles() {
	for list in ${prog_files}; do
		if [ -f "$list" ]; then
			cat "$list" >> /tmp/progs.csv
		else
			curl -Ls "$list" | sed '/^#/d' >> /tmp/progs.csv
		fi
	done
}

installationloop() {
	mergeprogsfiles 
	pacman --noconfirm --needed -S base-devel git >/dev/null 2>&1
	
	total=$(wc -l < /tmp/progs.csv)
	aurinstalled=$(pacman -Qm | awk '{print $1}')
	while IFS=, read -r tag program comment; do
		n=$((n+1))
		echo "$comment" | grep "^\".*\"$" >/dev/null 2>&1 && comment="$(echo "$comment" | sed "s/\(^\"\|\"$\)//g")"
		case "$tag" in
			"")  maininstall 	"$program" "$comment" || echo "$program" >> /home/${name}/failed ;;
			"A") aurinstall 	"$program" "$comment" || echo "$program" >> /home/${name}/failed ;;
			"G") gitmakeinstall "$program" "$comment" || echo "$program" >> /home/${name}/failed ;;
			"P") pipinstall 	"$program" "$comment" || echo "$program" >> /home/${name}/failed ;;
		esac
	done < /tmp/progs.csv
}

create_pack_ref() {
	dialog --infobox "Removing orphans..." 0 0
	pacman --noconfirm -Rns $(pacman -Qtdq) >/dev/null 2>&1
	sudo -u "$name" mkdir -p /home/"$USER"/.local/
	# creates a list of all installed packages for future reference
	pacman -Qq > /home/"$USER"/.local/Fresh_pack_list
}


##|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
##                 Start                    |||||||||||||||||||||
##|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
get_dialog 			|| error "Check your internet connection?"
get_microcode		|| error "Unable to get microcode"
confirm_n_go 		|| { clear; exit; }
get_deps
pacman_stuff
disable_beep
installationloop
create_pack_ref