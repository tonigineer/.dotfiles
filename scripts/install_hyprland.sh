#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_DIR/utils.sh"

sudo pacman -S base-devel
yay -S hyprland hyprpicker-git hyprlock-git hyprpaper-git mpvpaper-git
yay -S firefox discord_arch_electron

create_symlink .config/hypr
create_symlink .config/mpv

mkdir -p "/home/$USER/.local/share"
create_symlink .local/share/backgrounds
