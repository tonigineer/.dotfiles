#!/usr/bin/env bash

# This is a wrapper script for the volume window.
# Its main purpose is to automatically close the
# window after a certain duration. The duration
# restarts whenever a volume change is commanded.

EWW_WINDOW_NAME=notify-volume

if eww active-windows | grep -q "$EWW_WINDOW_NAME"; then
	date +%s >/tmp/timeout_eww_volume
	exit 0
fi

eww open "$EWW_WINDOW_NAME"
# Annoying workaround for my USB speaker
~/.config/hypr/scripts/soundctl.sh --equal_sinks
date +%s >/tmp/timeout_eww_volume

while "true"; do
	if [ $(expr $(date +%s) - 2) -gt $(</tmp/timeout_eww_volume) ]; then
		eww close "$EWW_WINDOW_NAME"
		exit 0
	fi

	sleep 0.1
done
