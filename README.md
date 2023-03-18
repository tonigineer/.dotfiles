# .dotfiles

Configuration for [Arch Linux](https://archlinux.org/) with [Hyprland](https://hyprland.org/)

[<kbd>Tokyonight-Moon</kbd>](https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme) | b | c
--- | --- | ---
a | b | c


## 🎨 Impressions

## <img src="assets/arch-linux.png" alt="launcher" width="7.5%"/> Setting up a fresh Arch Linux

<details><summary><b>Show instructions</b></summary>

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
sudo pacman -S base-devel git
cd /opt
sudo git clone https://aur.archlinux.org/yay.git
sudo chown -R USERNAME:USERNAME ./yay
cd yay
makepkg -si
```
</details>

## Configuring Hyprland