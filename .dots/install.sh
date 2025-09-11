#!/bin/bash

# Run this script on your user's first login (or anytime afterwards).
# This script installs my most commonly used programs.

DIRNAME="$(dirname "$0")"

exec 6>/dev/null # mute stdout by redirecting to &6

# install options

while getopts ":o:vh" o; do
    case "${o}" in
        h) echo "See README.md for help!" && exit 1 ;;
        f) PKGLIST=${OPTARG} ;;
        o) option=${OPTARG} ;;
        v) exec 6>&1 ;; # unmute by redirecting 6 back to 1
        *) echo "Invalid option: -$o $OPTARG" && exit 1 ;;
    esac
done

[ -z "$PKGLIST"] && PKGLIST=".dots/pkglist.csv"
[ -z "$option" ] && option="all"

install_aur() {
    # install various useful dev packages
    sudo pacman -S --needed git base-devel curl

    # install paru if needed
    if ! pacman -Qs paru >/dev/null ; then
        git clone https://aur.archlinux.org/paru.git
        cd paru
        makepkg -si
        cd ..
    fi
}

install_packages() {
    . "${DIRNAME}/install_pkglist.sh" "$PKGLIST" "$1"
}

# move things to where they need to be
move_dirs() {
    echo "Moving configuration files..."

    # TODO: use diff -bqr dirA dirB to see file differences

    cp -ri .config  ~
    cp -ri .local   ~
    ln -s ~/.config/shell/profile ~/.profile

    # TODO: firefox configs

    # link ncmpcpp-ueberzug
    ln -s ~/.config/ncmpcpp/ncmpcpp-ueberzug ~/.local/bin/
}

# vim stuff
vim_install() {
    echo "Installing vim stuff..."

    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim >&6 2>&1
    curl -fLo ~/.config/nvim/colors/jellybeans.vim --create-dirs \
        https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim >&6 2>&1
    nvim +'PlugInstall --sync' +qa
}

case "$option" in
    "some")
        install_aur
        install_packages
        vim_install
        ;;
    "all"|"full")
        move_dirs
        install_aur
        install_packages "1"
        vim_install
        ;;
    "vim")
        vim_install ;;
    "move")
        move_dirs ;;
esac

echo "Post install: See README.md"
