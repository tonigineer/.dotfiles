#!/usr/bin/env sh

# INSPIRED: https://github.com/ericmurphyxyz/dotfiles/blob/master/.local/bin/changevolume

function send_notification() {
    volume=$(pamixer --get-volume)
    dunstify -u low -r "9993" -h int:value:"$volume" -i "volume-$1" "Volume: ${volume}%" -t 2000
}

case $1 in
    up)
        # Set the volume on (if it was muted)
        # pamixer -u
        # pamixer -i 1 --allow-boost
        pactl set-sink-volume @DEFAULT_SINK@ +2%
        send_notification $1
        ;;
    down)
        # pamixer -u
        # pamixer -d 1 --allow-boost
        pactl set-sink-volume @DEFAULT_SINK@ -2%
        send_notification $1
        ;;
    mute)
        # pamixer -t
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        if $(pamixer --get-mute); then
            dunstify -i icons8-mute-53 -a "changevolume" -t 2000 -r 9993 -u low "Muted"
        else
            send_notification up
        fi
        ;;
esac