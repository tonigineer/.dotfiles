# <img src="assets/header.png" alt="launcher" width="50%"/>

<a href="https://git.io/typing-svg"><img src="https://readme-typing-svg.demolab.com?font=Fira+Code&pause=1000&color=F7D924&center=true&vCenter=true&width=435&lines=work+in+progress+..." alt="Typing SVG" /></a>

## 🎨 Impressions

## <img src="assets/arch-linux.png" alt="launcher" width="5%"/> Setting up a fresh Arch Linux

<details><summary><b>Show installation instructions</b></summary>

<br>

After booting into the Live Environment use [archinstall](https://wiki.archlinux.org/title/archinstall) or do it manually with the [installation guide](https://wiki.archlinux.org/title/installation_guide).

```sh
pacman -Sy archlinux-keyring
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

[Installation of Hyprland](https://wiki.hyprland.org/Getting-Started/Installation/) via [Yay](https://aur.archlinux.org/packages/yay). [Kitty](https://sw.kovidgoyal.net/kitty/) is the default terminal application, that can be left out if a different application is used.

```sh
sudo pacman -Sy kitty
yay -Sy hyprland-git

Hyprland
```
