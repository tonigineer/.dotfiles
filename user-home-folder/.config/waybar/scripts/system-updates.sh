#!/usr/bin/env bash

if [ ! -f /etc/arch-release ]; then
    echo {"text": " ?", "tooltip": "You are not using , btw!"}
fi

AUR=$(yay -Qu | wc -l)
AUR_PACKAGES=$(yay -Qu | sed -z 's/\n/\\n/g; s/..$//')  # add \n as linebreak to have a list in the tooltip

# Show number of updates for certain service
if [ "$AUR" = 0 ]; then
    echo '{"text": "󰕥", "tooltip": "System is up to date"}'
else
    echo '{"text": "  '${AUR}'", "tooltip": "'${AUR_PACKAGES}'"}'
fi

# If the parameter is "update", update all services
if [ "$1" = "update" ]; then
    alacritty --title "aur-update float" -e sh -c "yay -Qu && yay -Syu"
fi