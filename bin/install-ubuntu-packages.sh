#!/bin/bash
echo "Installing packages..."
sudo apt install xserver-xorg-input-evdev stow curl zsh i3 compton rofi dunst xautolock python3-pip gawk

echo "Installing zplug..."
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

echo "Installing vim-plug..."
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
