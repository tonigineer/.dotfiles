#!/usr/bin/env bash

# SOURCE: https://wiki.hyprland.org/Configuring/Uncommon-tips--tricks/#toggle-animationsbluretc-hotkey

HYPRGAMEMODE=$(hyprctl getoption animations:enabled | sed -n '2p' | awk '{print $2}')
if [ "$HYPRGAMEMODE" = 1 ]; then

	# with scaling other than 1, no 4K resolution available in steam
	hyprctl keyword monitor DP-1,prefered@60,0x0,1
	hyprctl keyword monitor DP-2,disable

	# kill application for wallpaper
	# pkill swww
	# pkill waybar

	# disable fancy hyprland stuff
	hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:drop_shadow 0;\
        keyword decoration:blur 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 1;\
        keyword decoration:rounding 0" &&
		notify-send --icon="icons8-game-controller-80" --expire-time=3000 'Hyprland' '\nGamemode activated!'
	exit
fi

# hyprctl keyword monitor DP-1,prefered@60,0x0,2
# hyprctl keyword monitor DP-2,disable
hyprctl reload && notify-send --icon="icons8-game-controller-80" --expire-time=3000 'Hyprland' '\nGamemode deactivated!'
