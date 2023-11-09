#!/usr/bin/env bash

LIVE_DIR=~/.local/share/backgrounds/live


case $1 in
    swww)
        pkill hyprpaper; pkill mpvpaper
        case $2 in
        next)
            wallpaper.sh next
        ;;

        reset)
            wallpaper.sh reset
        ;;
        esac
    ;;
    mpv)
        pkill hyprpaper; pkill swww; pkill mpvpaper

        cd $LIVE_DIR
        file=$(ls | shuf -n 1)

        mpvpaper -p -f -o --loop DP-1 $file
        mpvpaper -p -f -o --loop DP-2 $file
    ;;

    *)
        echo "First argument must be either \`swww\` or \`mpv\`."
    ;;
esac