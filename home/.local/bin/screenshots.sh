#!/usr/bin/env bash

SCREENSHOT_DIR=~/Pictures/Screenshots/

if [ ! -d "$SCREENSHOT_DIR" ]; then
	mkdir $SCREENSHOT_DIR
fi

# Take screen with `selecting area`
IMG=$SCREENSHOT_DIR$(date +'Screenshot_%Y-%m-%d_%H-%M-%S.png') &&
	grim -g "$(slurp)" "$IMG" && wl-copy <"$IMG" &&
	notify-send -a "grim" -i "icons8-screenshot-100" \
		"Screenshot taken" "Copied to clipboard & saved to\n$SCREENSHOT_DIR"

# https://sr.ht/~emersion/grim/

paplay ~/.local/share/sounds/reward.ogg
