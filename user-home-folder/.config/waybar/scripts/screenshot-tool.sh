#!/usr/bin/env bash

SCREENSHOT_DIR=~/Pictures/Screenshots/

if [ ! -d "$SCREENSHOT_DIR" ]; then
    mkdir $SCREENSHOT_DIR
fi

# Take screen with `selecting area`
# >> Screenshot will `be saved`` and `copied to clipboard``
IMG=$SCREENSHOT_DIR$(date +'Screenshot_%Y-%m-%d_%H-%M-%S.png') && grim -g "$(slurp)" $IMG && wl-copy < $IMG && notify-send "Screenshot" "Saved & Copied";

# https://sr.ht/~emersion/grim/