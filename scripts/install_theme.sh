#!/usr/bin/env bash

yay -S candy-icons rose-pine-cursor rose-pine-hyprcursor \
    tokyonight-gtk-theme-git ttf-cascadia-code-nerd

# currently, needed to pull the repo manually for the icons to work
# https://github.com/EliverLara/candy-icons

# Apply theme right now
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../home/.config/hypr/scripts/theme_apply.sh \
    Tokyonight-Dark \
    candy-icons \
    BreezeX-RosePine-Linux 24 \
    "CaskaydiaCove Nerd Font 10"
