#!/bin/bash

# Run this script after getting Arch initially installed. 
# This script installs my most commonly used programs.

# install paru
sudo pacman -S --needed git base-devel curl
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..

gitinstall() {
    program="$(basename "$1" .git)"
    git clone --depth 1 "$1" "$program"
    cd "$program"
    make
    make install
    cd ..
}

# install all packages, inspired heavily by larbs
install() {
    grep -v "^\s*#" pkglist.csv > /tmp/pkglist.csv
    local total=$(wc -l < /tmp/pkglist.csv)
    while IFS=, read -r tag program comment; do
        n=$((n+1))
        comment=`sed -e 's/^\s*"//' -e 's/"$//' <<< "$comment"`
        echo "Installing \`$program\` ($n of $total) from $tag. $program $comment"
        case "$tag" in
            "A") sudo paru -S --noconfirm "$program" >/dev/null 2>&1 ;;
            "G") echo "not supported yet..." ;; # gitinstall "$program" ;;
            "P") pip install "$program" >/dev/null 2>&1 ;;
            "C") cargo install "$program" >/dev/null 2>&1 ;;
            "N") npm install -g "$program" >/dev/null 2>&1 ;;
            *) sudo pacman --noconfirm --needed -S "$program" >/dev/null 2>&1 ;;
        esac
    done < /tmp/pkglist.csv ;
}
install

# move things to where they need to be
cp -ri .config  ~
cp -ri .local   ~
ln -s ~/.config/x11/xprofile ~/.xprofile 
ln -s ~/.config/shell/profile ~/.zprofile

# vim stuff
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.config/nvim/colors/jellybeans.vim --create-dirs \
    https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim
nvim +'PlugInstall --sync' +qa

# set default wallpaper
feh --bg-fill .local/share/default-wallpaper.jpg

echo "Post install: 
- Install nvm if needed.
- Install uim if wanted."