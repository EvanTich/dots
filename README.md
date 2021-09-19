# dots
 My dots. Generally, I like things dark and compact.

Default wallpaper is by [Alena Aenami](https://www.artstation.com/aenamiart). She is an amazing artist with a noticeable style.

## Before Running the Install Script
Follow the Arch [installation guide](https://wiki.archlinux.org/title/Installation_guide) and [general recommendations](https://wiki.archlinux.org/title/General_recommendations). 
Check out the commands below too (run as root).

```sh
# Install and enable NetworkManager.
pacman -S networkmanager
systemctl enable NetworkManager.service

# Install GRUB (change --efi-directory to where you mounted your efi partition)
# If you want to dual-boot alongside Windows, install os-prober and ntfs-3g
pacman -S grub efivar os-prober ntfs-3g
grub-install --target=x86_64-efi --efi-directory=/boot/efi/ --bootloader-id=GRUB
# uncomment GRUB_DISABLE_OS_PROBER from /etc/default/grub if dual-booting
vim /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

# Create a user (replace 'username' with what you want) and set their password.
useradd -m -g users -G wheel -s /bin/zsh username
passwd username

# Edit /etc/pacman.conf to make pacman and paru colorful.
grep -q "^Color" /etc/pacman.conf || sed -i "s/^#Color$/Color/" /etc/pacman.conf

# Edit /etc/makepkg.conf to use all cores for compilation.
sed -i "s/-j2/-j$(nproc)/;s/^#MAKEFLAGS/MAKEFLAGS/" /etc/makepkg.conf

# Edit /etc/sudoers to allows yourself to use some commands without entering a password. 
# The commands might need to be changed to personal preference.
echo "%wheel ALL=(ALL) ALL
%wheel ALL=(ALL) NOPASSWD: /usr/bin/shutdown,/usr/bin/reboot,/usr/bin/systemctl suspend,/usr/bin/wifi-menu,/usr/bin/mount,/usr/bin/umount,/usr/bin/pacman -Syu,/usr/bin/pacman -Syyu,/usr/bin/systemctl restart NetworkManager,/usr/bin/pacman -Syyu --noconfirm,/usr/bin/loadkeys,/usr/bin/paru" >> /etc/sudoers
```

## During the Install Script
Go get some coffee, sit outside, listen to the rain, etc. Enjoy yourself.

### Install Script Help
#### `-h`
- Points you in the direction of this README
#### `-o (some|all|vim|move)`
- Tells the script generally what you want it to do. 
- `"some"` only tries to install packages not already installed.
- `"all"` goes through the whole install process.
- `"vim"` only installs and sets up vim stuff.
- `"move"` sets up the home directory, and moves `.config` and `.local`.


### Things Installed
[Packages](./pkglist.csv) are sorted in the following order: important → tools (including python, cargo, npm) → everyday software → themes → fun stuff

## After Running the Install Script
Install computer-specific packages (like display drivers) and other things that fit your fancy (like `zsh-syntax-highlighting`). Start/enable services like `bluetooth.service`, `fstrim.timer` if you have an SSD that supports discarding. Install microcode updates `amd-ucode` or `intel-ucode` (see the [wiki](https://wiki.archlinux.org/title/microcode)). [Install Steam](https://wiki.archlinux.org/title/steam).

### Other Cool Things
Another bar like `polybar`, or [yabar](https://github.com/geommer/yabar).
GTK themes like `arc-gtk-theme`, `numix-gtk-theme`, [flat-remix-gtk](https://github.com/daniruiz/Flat-Remix-GTK), or [more](https://wiki.archlinux.org/title/GTK). 
[gruvbox](https://github.com/morhetz/gruvbox), or [iceberg](https://github.com/cocopon/iceberg.vim) themes for vim. 
Fun scripts/programs like [pipes.sh](https://github.com/pipeseroni/pipes.sh), [cliclock](https://github.com/clyde80/cliclock), or [ndvd](https://github.com/lennypeers/ndvd).
Fonts like [Fantasque Sans Mono](https://github.com/belluzj/fantasque-sans), [nerd-fonts-iosevka](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Iosevka), or [more](https://wiki.archlinux.org/title/fonts).
Tools for other things include `github-cli`, 
[Quiet theme](https://github.com/QuietTheme) looks pretty nice and has options for multiple different applications (vim, gtk, etc.).
A display manager for a nice loggin screen like [ly](https://github.com/nullgemm/ly), [lightdm](https://github.com/CanonicalLtd/lightdm/), or [more](https://wiki.archlinux.org/title/Display_manager)

### Things that Might be of Interest
- [uim](https://wiki.archlinux.org/title/Input_Japanese_using_uim) for Japanese character input.
- [awesome-console-services](https://github.com/chubin/awesome-console-services) for a neat curated list of website services (usable with `curl`).
- [suckless](https://suckless.org/) and the many listed projects that are inspired by suckless.
