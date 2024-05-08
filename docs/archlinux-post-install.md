# Post-Installation of Arch Linux

Things to do after the installation process for [Arch Linux](https://archlinux.org/).

## Mandatory

Installation of [yay](https://github.com/Jguer/yay) for the [Arch User Repository (AUR)](https://wiki.archlinux.org/title/Arch_User_Repository).

```bash
sudo pacman -S base-devel git vim
cd /opt
sudo git clone https://aur.archlinux.org/yay.git
sudo chown -R USERNAME:GROUP ./yay
cd yay
makepkg -si
```

Changes to [pacman](https://wiki.archlinux.org/title/pacman) package manager for people with style and a fast internet connection.

```bash
sudo vim /etc/pacman.conf
# Uncomment the following
ParallelDownloads = 10
Color
# Add the following (must be under [options])
ILoveCandy
```

Some miscellaneous:

```bash
echo "set noswapfile" > ~/.vimrc
```