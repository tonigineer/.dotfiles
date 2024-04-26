#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source $SCRIPT_DIR/utils.sh

sudo pacman -S base-devel
yay -S hyprland-git hyprpicker-git hyprlock-git hyprpaper-git

create_symlink .config/hypr

mkdir -p /home/$USER/.local/share
create_symlink .local/share/backgrounds
