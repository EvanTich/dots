#!/bin/bash

# Run this script on your user's first login (or anytime afterwards). 
# This script installs my most commonly used programs.

exec 6>/dev/null # mute stdout by redirecting to &6

# install options

while getopts ":o:vh" o; do 
    case "${o}" in
        h) echo "See README.md for help!" && exit 1 ;;
        o) option=${OPTARG} ;;
        v) exec 6>&1 ;; # unmute by redirecting 6 back to 1
        *) echo "Invalid option: -$o $OPTARG" && exit 1 ;;
    esac 
done

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

git_install() {
    program="$(basename "$1" .git)"
    git clone --depth 1 "$1" "$program"
    cd "$program"
    make
    make install
    cd ..
}

install_msg() {
    echo "Installing \`$1\` ($4 of $5) from $3. $1 $2"
}

already_installed() {
    echo "$1 ($2 of $3) is already installed! Skipping..."
}

# install all packages, inspired heavily by larbs
install() {
    [ -z "$1" ] && nocheck="1"
    grep -v "^\s*#" pkglist.csv > /tmp/pkglist.csv
    local total=$(wc -l < /tmp/pkglist.csv)
    while IFS=, read -r tag program comment; do
        n=$((n+1))
        comment=`sed -e 's/^\s*"//' -e 's/"$//' <<< "$comment"`
        case "$tag" in
        "A") 
            if [ -z "$nocheck" ] || ! pacman -Qs "$program" >/dev/null ; then
                install_msg "$program" "$comment" "the AUR" "$n" "$total"
                paru -S --noconfirm "$program" >&6 2>&1 
            else
                already_installed "$program" "$n" "$total"
            fi ;;
        "G") 
            # install_msg $program $comment "git" $n $total
            # git_install "$program"
            echo "git not supported yet... Skipping $program." ;; 
        "P") 
            if [ -z "$nocheck" ] || ! pip list | grep -q "$program" ; then
                install_msg "$program" "$comment" "pip" "$n" "$total"
                pip install "$program" >&6 2>&1 
            else
                already_installed "$program" "$n" "$total"
            fi ;;
        "C")
            if [ -z "$nocheck" ] || ! cargo install --list | grep -q "$program" ; then
                install_msg "$program" "$comment" "Cargo" "$n" "$total"
                cargo install "$program" >&6 2>&1 
            else
                already_installed "$program" "$n" "$total"
            fi ;;
        "N") 
            if [ -z "$nocheck" ] || ! npm list -g | grep -q "$program" ; then
                install_msg "$program" "$comment" "npm" "$n" "$total"
                sudo npm install -g "$program" >&6 2>&1
            else
                already_installed "$program" "$n" "$total"
            fi ;;
        *) 
            if [ -z "$nocheck" ] || ! pacman -Qs "$program" >/dev/null ; then
                install_msg "$program" "$comment" "pacman" "$n" "$total"
                sudo pacman --noconfirm --needed -S "$program" >&6 2>&1 
            else
                already_installed "$program" "$n" "$total"
            fi ;;
        esac
    done < /tmp/pkglist.csv ;
}

# move things to where they need to be
move_dirs() {
    echo "Moving configuration files..."

    # TODO: use diff -qr dirA dirB to see file differences

    cp -ri .config  ~
    cp -ri .local   ~
    ln -s ~/.config/x11/xprofile ~/.xprofile 
    ln -s ~/.config/shell/profile ~/.zprofile

    # TODO: firefox configs
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

wallpaper() {
    # set default wallpaper
    echo "Setting default wallpaper..."
    feh --bg-max ~/.local/share/default-wallpaper.jpg
}

case "$option" in
    "some")
        install_aur
        install
        vim_install
        ;;
    "all"|"full")
        move_dirs
        install_aur
        install "1"
        vim_install
        wallpaper
        ;;
    "vim")
        vim_install ;;
    "move")
        move_dirs ;;
esac

echo "Post install: See README.md"