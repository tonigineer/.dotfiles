#!/usr/bin/env sh

# SOURCE: https://wiki.hyprland.org/Configuring/Uncommon-tips--tricks/#toggle-animationsbluretc-hotkey

HYPRGAMEMODE=$(hyprctl getoption animations:enabled | sed -n '2p' | awk '{print $2}')
if [ $HYPRGAMEMODE = 1 ] ; then
    # with scaling other than 1, no 4K resolution available in steam
    way-displays -s SCALE "DP-1" 1

    # kill application for wallpaper
    pkill swww

    # disable fancy hyprland stuff
    hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:drop_shadow 0;\
        keyword decoration:blur 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 1;\
        keyword decoration:rounding 0"
    exit
fi

way-displays -s SCALE "DP-1" 2
hyprctl reload