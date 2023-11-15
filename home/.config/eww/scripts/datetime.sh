#!/usr/bin/env bash

case $1 in
    --toogle-calendar)
        if [ -f "/tmp/eww-cal.lock" ]; then
            rm /tmp/eww-cal.lock
            eww -c $HOME/.config/eww/bar close calendar
        else
            touch /tmp/eww-cal.lock
            eww -c $HOME/.config/eww/bar open calendar --screen 0
        fi
    ;;
    *)
        exit 1
    ;;
esac