# dots
 My dots. Generally, I like things dark and compact.

Default wallpaper is by [Alena Aenami](https://www.artstation.com/aenamiart). She is an amazing artist with a noticeable style.

## Before Running the Install Script
Follow the Arch [installation guide](https://wiki.archlinux.org/title/Installation_guide) and [general recommendations](https://wiki.archlinux.org/title/General_recommendations). 
Find a nice [display manager](https://wiki.archlinux.org/title/Display_manager) for a nice login screen.
Check out the commands below too.

Edit /etc/pacman.conf to make pacman and paru colorful.
```sh
grep -q "^Color" /etc/pacman.conf || sed -i "s/^#Color$/Color/" /etc/pacman.conf
```

Edit /etc/makepkg.conf to use all cores for compilation.
```sh
sed -i "s/-j2/-j$(nproc)/;s/^#MAKEFLAGS/MAKEFLAGS/" /etc/makepkg.conf
```

Make zsh the default shell for the user.
```sh
chsh -s /bin/zsh "$name" >/dev/null 2>&1
sudo -u "$name" mkdir -p "/home/$name/.cache/zsh/"
```

Edit /etc/sudoers to allows yourself to use some commands without entering a password. The commands might need to be changed to personal preference.
```sh
echo "%wheel ALL=(ALL) ALL
%wheel ALL=(ALL) NOPASSWD: /usr/bin/shutdown,/usr/bin/reboot,/usr/bin/systemctl suspend,/usr/bin/wifi-menu,/usr/bin/mount,/usr/bin/umount,/usr/bin/pacman -Syu,/usr/bin/pacman -Syyu,/usr/bin/systemctl restart NetworkManager,/usr/bin/rc-service NetworkManager restart,/usr/bin/pacman -Syyu --noconfirm,/usr/bin/loadkeys,/usr/bin/paru" >> /etc/sudoers
```

## During the Install Script
Go get some coffee, sit outside, listen to the rain, etc. Enjoy yourself.

## After Running the Install Script
Install computer-specific packages (like display drivers) and other things that fit your fancy (like `zsh-syntax-highlighting`). 

### Other Cool Things
Another bar like `polybar` or [yabar](https://github.com/geommer/yabar).
GTK themes like `arc-gtk-theme`, `materia-gtk-theme`, `numix-gtk-theme`, [flat-remix-gtk](https://github.com/daniruiz/Flat-Remix-GTK) or [more](https://wiki.archlinux.org/title/GTK). 
[Quiet](https://github.com/QuietTheme/Vim), [gruvbox](https://github.com/morhetz/gruvbox), or [iceberg](https://github.com/cocopon/iceberg.vim) themes for vim. 
Fun scripts/programs like [pipes.sh](https://github.com/pipeseroni/pipes.sh), [cliclock](https://github.com/clyde80/cliclock), or [ndvd](https://github.com/lennypeers/ndvd).
Fonts like [Fantasque Sans Mono](https://github.com/belluzj/fantasque-sans), [nerd-fonts-iosevka](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Iosevka), or [more](https://wiki.archlinux.org/title/fonts).
Tools for other things include `github-cli`, 
[Quiet theme](https://github.com/QuietTheme) looks pretty nice and has options for multiple different applications.


### Things Installed
[Packages](./pkglist.csv) are sorted in the following order: important → tools (including python, cargo, npm) → everyday software → themes → fun stuff

TODO: sort things in pkglist instead of listing them here

 | Important Stuff | |
| - | - |
distro | arch 
wm | i3-gaps
shell | zsh
compositor | picom
terminal | kitty
file manager | lf
file manager gui | ?
browser | firefox
notification manager | dunst
text editor | neovim
audio | pulseaudio
bluetooth | ?
media controller | playerctl
| | |

| Useful Stuff | |
| - | - |
image viewer | feh
media player | mpv
pdf/comic viewer | zathura
screenshot tool | flameshot
music player | mpd + ncmpcpp
fetcher | neofetch
process viewer | htop
activity monitor | gotop
trashcan | [trash-cli](https://github.com/andreafrancia/trash-cli)
rss reader | newsboat
| | |

| General Software | |
| - | - |
games | steam
social | discord
music | spotify
office stuff | ?
zoom | zoom*
help the eyes | redshift?
torrents | qbittorent
| | |

| Themes | |
| - | - |
gtk theme | materia dark compact
icons | papirus
color schemes | pywal
vim theme | 
vim theme | jellybeans
font | nerd-fonts-iosevka
| | |

| Programming | |
| - | - |
git | git, github-cli
uml | plantuml
node.js | nvm?, npm, node
rust | cargo, rust
C# | .NET
python | python3
go | go
| | |

| Fun Stuff | |
| - | - |
audio visualizer | cava
bonsai | [cbonsai](https://gitlab.com/jallbrit/cbonsai)
dvd bouncy | 
img to ascii | [tai](https://github.com/MustafaSalih1993/tai)
cheat engine | [gameconqueror](https://github.com/scanmem/scanmem)
tldr | [tldr](https://github.com/tldr-pages/tldr)
better ls | [exa](https://github.com/ogham/exa)
steam locomotive | [sl](https://github.com/mtoyoda/sl)
| | |

### Things that Might be of Interest
- [uim](https://wiki.archlinux.org/title/Input_Japanese_using_uim) for Japanese character input.
- [awesome-console-services](https://github.com/chubin/awesome-console-services) for a neat curated list of website services (usable with `curl`).
- [suckless](https://suckless.org/) and the many listed projects that are inspired by suckless.
