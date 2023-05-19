<div align="center">
    <img src="assets/header.png" alt="launcher" width="50%"/>
</div>

<div align="center">
<img src="https://img.shields.io/github/last-commit/tonigineer/.dotfiles?style=for-the-badge&logo=github&color=a6da95&logoColor=D9E0EE&labelColor=302D41"/>
<img src="https://img.shields.io/github/repo-size/tonigineer/.dotfiles?style=for-the-badge&logo=dropbox&color=7dc4e4&logoColor=D9E0EE&labelColor=302D41"/><br>
<a href="https://git.io/typing-svg"><img src="https://readme-typing-svg.demolab.com?font=Fira+Code&pause=1000&color=F7D924&center=true&vCenter=true&width=435&lines=work+in+progress+..." alt="Typing SVG" /></a>
</div>

## 🎨 Impressions

<div align="center">
<kbd><img alt="just-wallpaper-with-waybar" src="./assets/impressions-wallpaper.png" style="width: 600px;"/></kbd>
<kbd><img alt="just-wallpaper-with-rofi" src="./assets/impressions-rofi.png" style="width: 600px;"/></kbd>
<kbd><img alt="short-workflow" src="./assets/short-workflow.gif" style="width: 600px;"/></kbd>
</div>

## 🔥 To Do's

- [ ] Include cava into Spotify meta data

## 📖 Overview

<details open>
<summary><b>🔬 Display</b></summary>

>
<!-- Get some vertical space -->
<center>

🔹 Display Server: [Wayland](https://wiki.archlinux.org/title/Wayland)
🔹 Compositor: [Hyprland](https://hyprland.org/)
🔹 Bar: [Waybar](https://github.com/Alexays/Waybar)
</center>
</details>

<details open><summary><b>🌈 Appearance</b></summary>

>
<!-- Get some vertical space -->

🔸 Color scheme: [Tokyonight-Dark-BL-LB](https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme)
🔸 Cursor: [Catppuccin-Mocha-Light-Cursors](https://github.com/catppuccin/cursors)
🔸 Icons: [Win 11 icon theme](https://www.gnome-look.org/p/1546069)
</details>

<details open><summary><b>💾 Applications</b></summary>

>
<!-- Get some vertical space -->

</details>

<details open><summary><b>🚗 Ricing</b></summary>

>
<!-- Get some vertical space -->

</details>


## 🥼 Installation

<details><summary><img src="assets/arch-linux.png" alt="launcher" width="3%"/> Setting up a fresh Arch Linux</summary>

>
<!-- Get some vertical space -->

After booting into the Live Environment use [archinstall](https://wiki.archlinux.org/title/archinstall) or do it manually with the [installation guide](https://wiki.archlinux.org/title/installation_guide).

> **Note**: It is highly recommended to refer to the official [installation guide](https://wiki.archlinux.org/title/archinstall) and [general recommendations](https://wiki.archlinux.org/title/General_recommendations).

> **Note**: Without a wired connection, [iwctl](https://man.archlinux.org/man/community/iwd/iwctl.1.en) can be used within the Live Environment to connect to a wireless connection. After a reboot, [nmwli](https://man.archlinux.org/man/nmcli.1.en) can be used.

```sh
pacman -Sy archlinux-keyring  # may be needed? not sure anymore.
archinstall  # configure `minimal` installation
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

Installation of an [AUR Helper](https://wiki.archlinux.org/title/AUR_helpers), here [Yay](https://aur.archlinux.org/packages/yay).

```sh
sudo pacman -S base-devel git vim
cd /opt
sudo git clone https://aur.archlinux.org/yay.git
sudo chown -R USERNAME:USERNAME ./yay
cd yay
makepkg -si
```

<!-- [Installation](https://wiki.hyprland.org/Getting-Started/Installation/) of [Hyprland](https://hyprland.org/) via [Yay](https://aur.archlinux.org/packages/yay). [Kitty](https://sw.kovidgoyal.net/kitty/) is the default terminal application, that can be launch by `MOD + Q`.

```sh
sudo pacman -Sy kitty
yay -Sy hyprland-git
Hyprland  # start Hpyrland from the tty
``` -->

Clone repository and run installation script

```sh
cd Downloads
git clone https://github.com/tonigineer/.dotfiles.git
cd .dotfiles

./install.sh
```

Manual steps to finish installation

> **Note**: Automate as well ;)

```sh
# Install oh-my-fish for fish
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

# Within fish install theme
omf install kawasaki
```

## 🛠️ Fixes, settings and more

Some applications need further fixes. Especially, `fractional scaling` on [Wayland](https://pointieststick.com/2022/12/16/this-week-in-kde-wayland-fractional-scaling-oh-and-we-also-fixed-multi-screen/) does not work for every application so well. An application looks kind of blurry and/or some does not apply a 4K resolution, e.g., not available in [Steam](https://wiki.archlinux.org/title/steam) games.

> **Note**: This section serves as kind of a wiki to myself.

<details><summary><b>Appearance</b></summary>

>
<!-- Get some vertical space -->

Here are the steps to change the appearance accordingly. Application of the themes-stuff is done within [hyprland.conf](user-home-folder/.config/hypr/hyprland.conf), the rest is copying files.

```sh
cd ~/Downloads

wget https://ppload-com.s3.eu-central-1.amazonaws.com/data/files/1580555858/volantes-light-cursors.tar.gz?response-content-disposition=attachment%3B%2520volantes-light-cursors.tar.gz&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIATLQUPBWASZL2ZPWI%2F20230510%2Feu-central-1%2Fs3%2Faws4_request&X-Amz-Date=20230510T195654Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Signature=05e90bdedabd8bcdfbe5616832d02c00183420b4739acb977a0ff24673bb9f49
tar -zxvf volantes-light-cursors.tar.gz

git clone https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme

# Cursor
sudo cp -r ~/Downloads/volantes_light_cursors /usr/share/icons

# Icons
sudo cp -r Tokyo-Night-GTK-Theme/icons/Tokyonight-Moon /usr/share/icons

# Theme
sudo cp -r Tokyo-Night-GTK-Theme/themes/Tokyonight-Dark-BL-LB /usr/share/themes
sudo cp -r Tokyo-Night-GTK-Theme/themes/Tokyonight-Dark-BL-LB/gtk-4.0 ~/.config

# Post-install
rm -rf volantes_light_cursors
rm -rf Tokyo-Night-GTK-Theme
```

</details>

<details><summary><b>Bluetooth</b></summary>

>
<!-- Get some vertical space -->

How to configure Bluetooth:

```sh
sudo pacman -S bluez bluez-utils

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

Enable autostart bluetooth by uncommenting `AutoEnable=true` in

```sh
vim /etc/bluetooth/main.conf
```

</details>

<details><summary><b>Discord</b></summary>

>
<!-- Get some vertical space -->

> **Note**: It's the same as with `Visual Studio Code` down below.

To get rid blurred Discord on [Wayland](https://wayland.freedesktop.org/), start with following arguments:

```sh
discord --enable-features=UseOzonePlatform --ozone-platform=wayland
```

Here a command line to edit `/usr/share/applications/discord.desktop` accordingly:

```sh
sudo sed -i 's+Exec=/usr/bin/discord+Exec=/usr/bin/discord --enable-features=UseOzonePlatform --ozone-platform=wayland' /usr/share/applications/discord.desktop
```

</details>

<details><summary><b>Fonts</b></summary>

>
<!-- Get some vertical space -->

Fonts can be installed via [Yay](https://aur.archlinux.org/packages/yay) directly from the [AUR](https://aur.archlinux.org/). For example: [Split Package Details - nerd-fonts (any)](https://archlinux.org/packages/community/any/nerd-fonts/)

```sh
yay -Sy otf-cascadia-code-nerd
fc-cache -v  # to update fonts.
```

Installed fonts can be found via:

```sh
fc-list | grep Cas*
Caskaydia Cove Nerd Font Complete Bold Italic.otf: CaskaydiaCove Nerd Font:style=Bold Italic
```

> **Note**: In the example above `CaskaydiaCove Nerd Font` is th name of the font, that needs to be used in configuration files.

</details>

<details><summary><b>Spotify</b></summary>

>
<!-- Get some vertical space -->

To get rid of a blurred [Spotify](https://aur.archlinux.org/packages/spotify) on [Wayland](https://wayland.freedesktop.org/), install the following:

```sh
yay -S spotify-blur-me-not
```

</details>

<details><summary><b>Sound</b></summary>

>
<!-- Get some vertical space -->

Getting sound set up:

```sh
sudo pacman -Syu pulseaudio pulseaudio-bluetooth pavucontrol
pulseaudio --start
```

> **Note:** Use `pavucontrol` to start PulseAudio GUI.

</details>

<details><summary><b>Steam</b></summary>

>
<!-- Get some vertical space -->

> **Note**: First of all, great [tutorial](https://steamcommunity.com/sharedfiles/filedetails/?l=german&id=1787799592) on how to set up gaming on [Steam](https://wiki.archlinux.org/title/steam).

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

<details><summary><b>Visual Studio Code</b></summary>

>
<!-- Get some vertical space -->

To get rid of the [blurred Visual Studi Code](https://www.reddit.com/r/Fedora/comments/wpkws3/blurry_vscode_on_wayland_fractional_scaling/) on [Wayland](https://wayland.freedesktop.org/), start with the following arguments:

```sh
code --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland
```

Here a command line to edit `/usr/share/applications/code.desktop` accordingly:

```sh
sudo sed -i 's/code --unity-launch %F/code --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland/' /usr/share/applications/code.desktop
```

> **Note**: Changes to `code.desktop` are always reverted with updates.

</details>

<details><summary><b>way-displays</b></summary>

>
<!-- Get some vertical space -->

> **Note**: The use of [way-displays](https://github.com/alex-courtis/way-displays) is currently only needed to easily switch the `fractional scaling` and arrange two monitors correctly with scaling (Hyprland does in wrong order). If those things are fixed within [Hyprland](https://hyprland.org/)/[Wayland](https://wayland.freedesktop.org/), this tool is obsolete.

[Command line documentation](https://github.com/alex-courtis/way-displays/blob/master/doc/CONFIGURATION.md#command-line)

</details>
