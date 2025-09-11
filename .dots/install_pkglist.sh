#!/bin/bash

PKGLIST="${1:-".dots/pkglist.csv"}"
NOCHECK="$2"
SIMULATE="$3"

already_installed() {
    echo "$1 is already installed! Skipping..."
}

install_bulk() {
    tag_char="$1"
    installer="$2"
    program_name="$3"

    echo "Installing packages using $program_name"
    # filter comments and any line without the tag character
    grep -v -e '^\s*#' -e "^\s*$tag_char" "$PKGLIST" |
    # only get the package name
            cut -d, -f2 - |
    # run the install function
            "$installer"
}

install_pacman() {
    if [ -z "$SIMULATE" ]; then
        sudo pacman --needed -S -
    else
        echo "pacman --needed -S -"
        cat -
    fi
}

install_paru() {
    if [ -z "$SIMULATE" ]; then
        paru --needed -S -
    else
        echo "paru --needed -S -"
        cat -
    fi
}

install_cargo() {
    while read -r program; do
        if [ -z "$NOCHECK" ] || ! cargo install --list | grep -q "$program" ; then
            if [ -z "$SIMULATE" ]; then
                cargo install "$program"
            else
                echo "cargo install $program"
            fi
        else
            already_installed "$program"
        fi
    done
}

install_npm() {
    while read -r program; do
        if [ -z "$NOCHECK" ] || ! npm list -g | grep -q "$program" ; then
            if [ -z "$SIMULATE" ]; then
                sudo npm install -g "$program"
            else
                echo "npm install -g $program"
            fi
        else
            already_installed "$program"
        fi
    done
}

install_python() {
    while read -r program; do
        echo "Use pacman/paru for installing Python packages! Ignoring $program." >&2
    done
}

install_git() {
    while read -r program; do
        # programname="$(basename "$program" .git)"
        # git clone --depth 1 "$program" "$programname"
        # cd "$programname"
        # make
        # make install
        # cd ..
        echo "git not supported. Ignoring $program." >&2
    done
}

# time to install!
install_bulk '\w' install_pacman "pacman"
install_bulk '[^A]' install_paru "paru"
install_bulk '[^C]' install_cargo "cargo"
install_bulk '[^N]' install_npm "npm"
install_bulk '[^P]' install_python "pip"
install_bulk '[^G]' install_git "git"
