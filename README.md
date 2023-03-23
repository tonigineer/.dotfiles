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

[Installation](https://wiki.hyprland.org/Getting-Started/Installation/) of [Hyprland](https://hyprland.org/) via [Yay](https://aur.archlinux.org/packages/yay). [Kitty](https://sw.kovidgoyal.net/kitty/) is the default terminal application, that can be launch by `MOD + Q`.

```sh
sudo pacman -Sy kitty
yay -Sy hyprland-git

Hyprland  # start Hpyrland from the tty
```

Install all dependencies:

```sh
# MISSING theme, font, cursor, icons
yay -Sy warbar-hyprland-git nemo pulseaudio pulseaudio-bluetooth pavucontrol fish alacritty tree exa neovim
```

Copy `.dotfiles` and all the other stuff.

```sh

```

Final configuration steps.

```sh
# Set default terminal in nemo
gsettings set org.cinnamon.desktop.default-applications.terminal exec alacritty
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



## Gimmicks
TODO TODO TODO
```sh
pacman -Sy cava neofetch htop

    ### Display configuration 

    ```sh
    sudo pacman -Sy way-displays
    ```

    https://github.com/alex-courtis/way-displays

    create config from default and edit as needed

    call way-displays to apply config, think must be done every start
