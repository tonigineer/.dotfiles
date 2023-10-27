<div align="center">
    <img src="assets/header.png" alt="launcher" width="50%"/>
</div>

<div align="center">
<img src="https://img.shields.io/github/last-commit/tonigineer/.dotfiles?style=for-the-badge&logo=github&color=a6da95&logoColor=D9E0EE&labelColor=302D41"/>
<img src="https://img.shields.io/github/repo-size/tonigineer/.dotfiles?style=for-the-badge&logo=dropbox&color=7dc4e4&logoColor=D9E0EE&labelColor=302D41"/><br>
</div>

## 🎨 Impressions

<div align="center">
<kbd><img alt="just-wallpaper-with-waybar" src="./assets/impressions-wallpaper.png" style="width: 600px;"/></kbd>
<kbd><img alt="just-wallpaper-with-rofi" src="./assets/impressions-rofi.png" style="width: 600px;"/></kbd>
<kbd><img alt="short-workflow" src="./assets/short-workflow.gif" style="width: 600px;"/></kbd>
</div>

## 📖 Overview

<details open>
<summary><b>🔬 Display</b></summary>

>
<!-- Get some vertical space -->

➖ Display Server: [Wayland](https://wiki.archlinux.org/title/Wayland)
🔺 Compositor: [Hyprland](https://hyprland.org/)
🔺 Bar: [Waybar](https://github.com/Alexays/Waybar)
</details>

<details open><summary><b>🌈 Appearance</b></summary>

>
<!-- Get some vertical space -->

➖ Color scheme: [Tokyonight-Dark-BL-LB](https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme)
🔺 Cursor: [Volantes Cursors Light](https://github.com/varlesh/volantes-cursors)
🔺 Icons: [Tokyonight-Moon](https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme/tree/master/icons)
</details>

<details open><summary><b>📐 Configuration</b></summary>

>
<!-- Get some vertical space -->

➖ Shell: [ZSH](https://github.com/tonigineer/zsh)
🔺 Editor: [Neovim](https://github.com/tonigineer/nvim)
</details>


## 🥼 Installation

<details><summary><img src="assets/arch-linux.png" alt="launcher" width="3%"/> Setting up a fresh Arch Linux</summary>

>
<!-- Get some vertical space -->

After booting into the Live Environment, go either with my sparse [Installation Guide](/docs/archlinux-installation.md) or just use [archinstall](https://wiki.archlinux.org/title/archinstall).

> [!IMPORTANT]
> It is highly recommended to refer to the official [Installation Guide](https://wiki.archlinux.org/title/installation_guide) and [General Recommendations](https://wiki.archlinux.org/title/General_recommendations).

> [!NOTE]
>  Without a wired connection, [iwctl](https://man.archlinux.org/man/community/iwd/iwctl.1.en) can be used within the Live Environment to connect to a wireless connection. After a reboot, [nmwli](https://man.archlinux.org/man/nmcli.1.en) can be used.

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
git clone --recurse-submodules https://github.com/tonigineer/.dotfiles.git ~/.dotfiles
~/.dotfiles/scripts/install.sh
```

## 🛠️ Miscellaneous

Just some stuff to remember.

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
