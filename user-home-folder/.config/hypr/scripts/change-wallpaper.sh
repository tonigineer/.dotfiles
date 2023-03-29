#!/usr/bin/env bash

SWWW=~/.config/hypr/scripts/swww
WALLPAPER_DIR=~/.config/hypr/backgrounds/animated

# Create tooltips
wallpaper_current=$($SWWW query | grep -oP '(?<=").*(?=")')

wallpaper_avail=($WALLPAPER_DIR/*)
wallpaper_number=${#wallpaper_avail[@]}

tooltip_string="<b><i>Change wallpaper</i></b>\n"
i=0
for f in "${wallpaper_avail[@]}"; do
    filename="${f##*/}"
    if [ "$filename" = "$wallpaper_current" ]; then
        filename="<b> $filename</b>"
        wallpaper_prev=${wallpaper_avail[$(( i - 1 % $wallpaper_number))]}
        wallpaper_next=${wallpaper_avail[$(( i + 1% $wallpaper_number))]}
    else
        filename=" $filename"
    fi

    tooltip_string="$tooltip_string$filename"

    i=$(( i + 1 ))
    if (( i < wallpaper_number )); then
        tooltip_string="$tooltip_string\n"
    fi
done

if [ "$1" = "tooltip" ]; then
    echo '{"text": "󰸉", "tooltip": "'${tooltip_string}'"}'
    exit 0
fi

# Take care of starting daemon
sleep 0.1
if [ "$1" = "reset" ]; then
    $SWWW kill
fi
$SWWW query || $SWWW init

# Select randomly an animation
array[0]="--transition-fps 60 --transition-type random --transition-duration 2"
array[1]="--transition-fps 60 --transition-type grow --transition-pos 0.925,0.977 --transition-duration 2"
size=${#array[@]}
index=$(($RANDOM % $size))
animation=${array[$index]}

# Apply wallpaper
if [ "$1" = "next" ]; then
    $SWWW img $wallpaper_next $animation
fi

if [ "$1" = "prev" ]; then
    $SWWW img $wallpaper_prev $animation
fi

if [ "$1" = "reset" ]; then
    while true
    do
        random_file=$(find $WALLPAPER_DIR -type f | shuf -n 1)
        if [ "$random_file" != "$WALLPAPER_DIR/$current_wallpaper" ]; then
            break;
        fi
    done
    $SWWW img $random_file $animation
fi
