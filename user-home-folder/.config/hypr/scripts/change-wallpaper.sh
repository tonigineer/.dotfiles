#!/usr/bin/env bash

SWWW=~/.config/waybar/scripts/swww

# Take care of starting daemon
sleep 0.1
if [ "$1" = "reset" ]; then
    ~/.config/waybar/scripts/swww kill
fi
$SWWW query || $SWWW init

array[0]="--transition-fps 60 --transition-type random --transition-duration 2"
array[1]="--transition-fps 60 --transition-type grow --transition-pos 0.925,0.977 --transition-duration 2"

size=${#array[@]}
index=$(($RANDOM % $size))
animation=${array[$index]}

PATH_WALLPAPER=~/.config/waybar/backgrounds/animated
current_wallpaper=$($SWWW query | grep -oP '(?<=").*(?=")' | head -1)

while true
do
    random_file=$(find $PATH_WALLPAPER -type f | shuf -n 1)
    if [ "$random_file" != "$PATH_WALLPAPER/$current_wallpaper" ]; then
        break;
    fi
done

$SWWW img $random_file $animation
