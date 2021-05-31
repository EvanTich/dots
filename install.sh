#!/bin/bash

# Run this script after getting Arch initially installed. 
# This script installs my most commonly used programs.

# Important Stuff:
pacman -S picom dmenu dunst

# For AUR packages
pacman -S --needed git base-devel


# Text Editors:
pacman -S neovim
    
git clone https://aur.archlinux.org/vscodium.git
cd vscodium
makepkg -sri

# File Managers:
pacman -S lf
pacman -S exa

# Multimedia:
pacman -S \
    pulseaudio playerctl \
    feh mpv \
    cmus \
    zathura zathura-cb zathura-pdf-mupdf \
    flameshot \
    newsboat #\
    # mpd ncmpcpp 


# Terminal:
pacman -S \
    kitty \
    htop gotop

# Internet:
pacman -S firefox

# Font:

# Development:
pacman -S \
    nodejs npm \
    python python-pip \
    rust \
    plantuml #\
    # dotnet-runtime dotnet-sdk
    
echo "Install nvm from AUR if needed."

# General Software:

pacman -S \
    discord qbittorrent




# Other:
pacman -S python-pywal redshift
pip install trash-cli
cargo install tai
npm install -g tldr
pacman -S sl gameconqueror

# git clone https://gitlab.com/jallbrit/cbonsai.git
# cd cbonsai
# make install


# AUR:
echo "AUR packages: steam, spotify, zoom, vscodium, cava"
echo "See the ArchWiki on how to install AUR packages."

# Move things to where they need to be
cp -r .config ~/.config
cp -r .vim    ~/.vim
# vim stuff
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.vim/colors/jellybeans.vim --create-dirs \
    https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim

