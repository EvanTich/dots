#!/bin/sh

# Run this script after getting Arch initially installed. 
# This script installs my most commonly used programs.

# install all packages
grep -v "^\s*#" pkglist.txt | pacman -S --needed -

# install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -sri
cd ..

# install all aur packages
grep -v "^\s*#" pkglist-aur.txt | yay -S --needed -
echo "Install nvm from AUR if needed."

# install other stuff from other places
pip install trash-cli
cargo install tai
npm install -g tldr

# Move things to where they need to be
cp -r .config ~/.config
cp -r .vim    ~/.vim
# vim stuff
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.vim/colors/jellybeans.vim --create-dirs \
    https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim

