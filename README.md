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

### Shortcuts
M - Mod (Windows key, Command)\
C - Ctrl\
S - Shift

Shortcut | Description
--------:|------------
M+Return | Start terminal
M+S+Return | Start terminal and SSH
M+S+q    | Kill focused window
M+C+x    | Murder X window
M+d      | Program launcher
M+C+m    | Audio mixer
M+F1     | Run Nemo
M+F2     | Run Firefox
M+F3     | Run VSCode
M+F4     | Run Discord
M+S+F4   | Run Slack
M+F5     | Run Steam
M+F6     | Run Newsboat
M+0      | Power/System Menu
PrtSc    | Fullscreen(s) screenshot
M+PrtSc  | Screenshot active window
M+S+PrtSc | Screenshot selection
M+S+s    | Screenshot selection, save to clipboard
M+S+c    | Reload i3 config
M+S+r    | Restart i3 inplace
M+S+e    | Exit i3

### Vim
Neovim is setup with many different plugins and here I will compile a list of some useful shortcuts.

Plugin | Description
-------|------------
'sheerun/vim-polyglot' | Collection of language packs
'neoclide/coc.nvim' | Conquer of Completion; IntelliSense on crack, in vim
'yggdroot/indentline' | Indentation guides
'junegunn/goyo.vim' | Code focus; One file on one screen
'junegunn/limelight.vim' | Code focus; Only highlights the lines close to the cursor
'scrooloose/nerdtree' | Nerd Tree; Neat file browser for vim
'xuyuanp/nerdtree-git-plugin' | Git integration with the Nerd Tree file tree
'preservim/nerdcommenter' | Comment manipulation
'mhinz/vim-startify' | Start screen for vim. Looks very nice
'airblade/vim-gitgutter' | Git diffs in the gutter, like IDEs
'bronson/vim-trailing-whitespace' | Highlight trailing whitespace and automatically fix if wanted
'jiangmiao/auto-pairs' | Automatically pair delimiters like parentheses
'ryanoasis/vim-devicons' | Icons for Nerd Tree
'vim-airline/vim-airline' | Airline
'vim-airline/vim-airline-themes' | Airline themes
'dhruvasagar/vim-table-mode' | Markdown table creator
'vimwiki/vimwiki' | Personal wiki and organization
'liuchengxu/vim-which-key' | Helps with commands

L - Leader key (SPACE)

Shortcut | Description
--------:|------------
C+c      | Copy
C+p      | Paste
L+wh+{hjkl} | Move between splits
L+hl     | Reset highlighting from searches
L+fw     | Fix trailing whitespace
L+ct     | Toggle CoC terminal
L+rcw    | Rename current word
L+cso    | CoC outline
L+y      | CoC yank
L+col    | CocList