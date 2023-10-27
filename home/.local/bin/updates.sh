#!/usr/bin/env bash

if [ ! -f /etc/arch-release ]; then
	echo {"text": " ?", "tooltip": "You are not using , btw!"}
fi

yay -Sy >/dev/null 2>&1

AUR=$(yay -Qu | wc -l)
AUR_PACKAGES=$(yay -Qu | sed -z 's/\n/\\n/g; s/..$//') # add \n as linebreak to have a list in the tooltip

# Show number of updates for certain service
if [ "$AUR" = 0 ]; then
	echo '{"text": "<span size=\"115%\">󰏗</span> <span color=\"#f5e0dc\" size=\"75%\" rise=\"-3pt\"></span>", "class": "none", "tooltip": "System is up to date"}'
else
	echo '{"text": "<span size=\"115%\">󱧕</span> <span color=\"#f5e0dc\" size=\"75%\" rise=\"-3pt\">'${AUR}'</span>", "class": "updates", "tooltip": "'${AUR_PACKAGES}'"}'
fi

# If the parameter is "update", update all services
if [ "$1" = "update" ]; then
	alacritty --title "aur-update float" -e sh -c "yay -Qu && yay -Syyu"
fi
