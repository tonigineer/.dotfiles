# <img src="assets/header.png" alt="launcher" width="50%"/>

<a href="https://git.io/typing-svg"><img src="https://readme-typing-svg.demolab.com?font=Fira+Code&pause=1000&color=F7D924&center=true&vCenter=true&width=435&lines=work+in+progress+..." alt="Typing SVG" /></a>

<div align="center">
<img src="https://img.shields.io/github/last-commit/tonigineer/.dotfiles?style=for-the-badge&logo=github&color=a6da95&logoColor=D9E0EE&labelColor=302D41"/>
<img src="https://img.shields.io/github/repo-size/tonigineer/.dotfiles?style=for-the-badge&logo=dropbox&color=7dc4e4&logoColor=D9E0EE&labelColor=302D41"/>
</div>

## 🎨 Impressions

## <img src="assets/arch-linux.png" alt="launcher" width="5%"/> Setting up a fresh Arch Linux

<details><summary><b>Show installation instructions</b></summary>

<br>

After booting into the Live Environment use [archinstall](https://wiki.archlinux.org/title/archinstall) or do it manually with the [installation guide](https://wiki.archlinux.org/title/installation_guide).

```sh
pacman -Sy archlinux-keyring  # nay be needed? not sure anymore.
pacman -Sy archinstall

archinstall

# Configure your installation and proceed.
```

After rebooting and logging into your user, a [AUR Helper](https://wiki.archlinux.org/title/AUR_helpers) must be installed. Here, we use [Yay](https://aur.archlinux.org/packages/yay).

```sh
sudo pacman -S base-devel git vim
cd /opt
sudo git clone https://aur.archlinux.org/yay.git
sudo chown -R USERNAME:USERNAME ./yay
cd yay
makepkg -si
```

</details>

At first, the [pacman package manager](https://wiki.archlinux.org/title/pacman) needs to be prettied up.

```sh
sudo vim /etc/pacman.conf

# Uncomment the following
ParallelDownloads = 10
Color

# Add the following (must be under [options])
ILoveCandy
```

## 💻 Configuring Hyprland

[Installation](https://wiki.hyprland.org/Getting-Started/Installation/) of [Hyprland](https://hyprland.org/) via [Yay](https://aur.archlinux.org/packages/yay). [Kitty](https://sw.kovidgoyal.net/kitty/) is the default terminal application, that can be launch by `MOD + Q`.

```sh
sudo pacman -Sy kitty
yay -Sy hyprland-git

Hyprland  # start Hpyrland from the tty
```

Install all dependencies:

```sh
# MISSING theme, font, cursor, icons
yay -Sy warbar-hyprland-git nemo pulseaudio pulseaudio-bluetooth pavucontrol fish alacritty tree exa neovim xdg-user-dir way-displays neofetch
```

Copy `.dotfiles` and all the other stuff.

```sh
/user-home-folder/.tools/link_configuration.sh
```

Final configuration steps.

```sh
# Set default terminal in nemo
gsettings set org.cinnamon.desktop.default-applications.terminal exec alacritty

# Set up common user folder - https://command-not-found.com/xdg-user-dir
xdg-user-dirs-update
```

## Customization explanation

Collection of how to customize the look of the Rice, mostly intended to be a reminder to myself.

<details><summary><b>Fonts</b></summary>

Fonts can be installed via [Yay](https://aur.archlinux.org/packages/yay) directly from the [AUR](https://aur.archlinux.org/). For example: [Split Package Details - nerd-fonts (any)](https://archlinux.org/packages/community/any/nerd-fonts/)

```sh
yay -Sy otf-cascadia-code-nerd
fc-cache -v  # to update fonts.
```

Installed fonts can be found via

```sh
[toni@archlinux ~]$ fc-list | grep Cas*
/u/s/f/O/Caskaydia Cove Nerd Font Complete Bold Italic.otf: CaskaydiaCove Nerd Font:style=Bold Italic
```

> **CaskaydiaCove Nerd Font** is th name of the font, that needs to be used in configuration files.

</details>

<details><summary><b>Themes, Icons, Cursor</b></summary>

The `/scripts/apply_theme.sh` from this repo can be used to apply a downloaded theme.

```sh
yay -Sy plank-theme-tokyo-night

sh /scripts/apply_theme.sh theme list  # shows all installed themes
sh /scripts/apply_theme.sh theme THEME-NAME
```

</details>

<details><summary><b>Sound</b></summary>

Getting sound set up:

```sh
sudo pacman -Syu pulseaudio pulseaudio-bluetooth pavucontrol
pulseaudio --start
```

> Use `pavucontrol` to start PulseAudio GUI.

</details>

<details><summary><b>Bluetooth</b></summary>

How to configure Bluetooth:

```sh
pacman -Syu bluez bluez-utils

lsmod | grep btusb  # check if bluetooth module is loaded (should appear on list)
modprobe btusb # exec if not loaded

systemctl enable bluetooth.service
```

```sh
bluetoothctl

power on
agent on  # automatically connect trusted devices
default-agent

scan on
devices

trust <MAC-ADDRESS>  # tab completion :)
pair <MAC-ADDRESS>
connect <MAC-ADDRESS>
```

Enable autostart bluetooth by uncommenting AutoEnable=true in

```sh
vim /etc/bluetooth/main.conf
```

</details>

## Fixes and more

Some applications need further fixes. Especially, `fractional scaling` on [Wayland](https://pointieststick.com/2022/12/16/this-week-in-kde-wayland-fractional-scaling-oh-and-we-also-fixed-multi-screen/) does not work for every application so well. An application looks kind of blurry and/or some does not apply a 4K resolution, e.g., not available in [Steam](https://wiki.archlinux.org/title/steam) games.

<details><summary><b>Spotify (not solved yet)</b></summary>

</details>

<details><summary><b>Steam</b></summary>

> Btw, great [tutorial](https://steamcommunity.com/sharedfiles/filedetails/?l=german&id=1787799592) on how to set up gaming on [Steam](https://wiki.archlinux.org/title/steam).

### Missing 4K resolution

Currently, there is no cure for [Steam](https://wiki.archlinux.org/title/steam). The only thing I came up with, is to set the scaling back to `1` via:

```sh
way-displays -s SCALE "DP-1" 1
```
There is a button on the [Waybar](https://github.com/Alexays/Waybar) to activate `gamemode`. This script also takes care of some Hyprland stuff. Further information can be found within the script [itself](/user-home-folder/.config/hypr/scripts/gamemode.sh).

### Gamemod

[Gamemode](https://github.com/FeralInteractive/gamemode) can be used to get more performance for games.

```sh
gamemodedrun supertuxkart
```

### cpupower

To get all tests passed in `gamemoded -t`, [cpupower](https://wiki.archlinux.org/title/CPU_frequency_scaling#cpupower) can be used to adapt governor.

```sh
sudo vim `/etc/default/cpupower`
```

```vim
# Define CPUs governor
# valid governors: ondemand, performance, powersave, conservative, userspace.
governor='ondemand'
```

[cpupower](https://wiki.archlinux.org/title/CPU_frequency_scaling#cpupower) service must be started/enabled afterwards.

```sh
systemctl start cpupower.service
# or
systemctl enable cpupower.service
```

> I didn't go for `performance`, because the cooling was working at max. I think, `ondemand` should suffice.

</details>

<details><summary><b>way-displays</b></summary>

The use of [way-displays](https://github.com/alex-courtis/way-displays) is currently only needed to easily switch the `fractional scaling` and arrange two monitors correctly with scaling. If those things are fixed within [Hyprland](https://hyprland.org/)/[Wayland](https://wayland.freedesktop.org/), this tool is obsolete.

> [Command line documentation](https://github.com/alex-courtis/way-displays/blob/master/doc/CONFIGURATION.md#command-line)

</details>

<details><summary><b>Visual Studio Code</b></summary>

Visual Studi Code can be started with the following arguments ([source](https://www.reddit.com/r/Fedora/comments/wpkws3/blurry_vscode_on_wayland_fractional_scaling/)):

```sh
code --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland
```

> Set command line arguments to `/usr/share/applications/code.desktop`.

```sh
sed -i 's/code --unity-launch %F/code --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland/' /usr/share/applications/code.desktop
```

!update revert changes!!!

sudo sed

</details>




todfo


sudo pacman -Sy xfce4
xfce4-appearance-settings > hier kann man auch noch themes setzen

yay -Sy swaylock-effects-git


screenshots
yay -Sy grim-git slurp-git wl-clipboard
yay -Sy imv-git  # image viewer



IMG=~/Pictures/Screenshots/$(date +'Screenshot_%Y-%m-%d_%H-%M-%S.png') && grim -g "$(slurp)" $IMG && wl-copy < $IMG && notify-send "Screenshot" "Saved & Copied";

https://github.com/khaneliman/dotfiles/blob/main/dots/linux/hyprland/home/.config/hypr/windowrules.conf
https://github.com/SolDoesTech/hyprland
https://github.com/PROxZIMA/.dotfiles/blob/master/.config/hypr/hyprland.conf


pamixer muss fuer notifyu-voliume script mit installiert werden



discord.desktop in uar/share.applic ...
--enable-features=UseOzonePlatform --ozone-platform=wayland