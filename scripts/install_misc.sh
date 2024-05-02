#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_DIR/utils.sh"


#  EWW
yay -S eww-git socat net-tools inetutils iwd jq
create_symlink .config/eww

# Bluetooth/Sound
yay -S pavucontrol pipewire-pulse pipewire-alsa pipewire-audio playerctl
yay -S bluez bluez-utils
yay -S yt-dlp  # git comes with haskell
sudo systemctl enable bluetooth.service

# Filemanager
yay -S thunar thunar-volman gvfs-git xdg-user-dirs tumbler
xdg-user-dirs-update

# Launcher
yay -S rofi-lbonn-wayland-only-git
create_symlink .config/rofi

# Notifications
yay -S python-gobject python-dbus

# Screenshots
yay -S grim-git slurp-git
yay -S vlc wl-recorder

