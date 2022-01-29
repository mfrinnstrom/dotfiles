# dotfiles
My dotfiles

## Clone repo
```
git clone git@github.com:mfrinnstrom/dotfiles.git .dotfiles
```

## Install tools
```
sudo apt update
sudo apt install zsh stow keychain
```

## Install zplug
```
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
```

## Enable dotfiles
```
cd .dotfiles
stow git zsh nvim
```

## Install homebrew
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```