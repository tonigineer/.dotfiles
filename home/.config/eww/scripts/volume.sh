#!/usr/bin/env bash

# Summary: Volume management with notifications

function get_volume() {
	pamixer --get-volume
}

function is_muted() {
	pactl get-sink-mute @DEFAULT_SINK@ | grep "Mute: " | cut -d " " -f 2
}

function get_icon() {
	if [ "$(is_muted)" = "yes" ]; then
		echo "󰖁"
	else
		volume="$(get_volume)"
		if [[ "$(get_volume)" -eq "0" ]]; then
			echo "󰕿"
		elif [[ "$volume" -gt "0" && "$volume" -le "50" ]]; then
			echo "󰖀"
		elif [[ "$volume" -gt "50" && "$volume" -le "100" ]]; then
			echo "󰕾"
		fi
	fi
}

function send_notification() {
	volume=$(get_volume)
	dunstify \
		-u low \
		-a "pactl set-sink-volume @DEFAULT_SINK@" \
		-r "9993" \
		-h int:value:"$volume" \
		-i "volume-$1" "Volume: ${volume}%" \
		-t 2000
}

case $1 in
--get-volume)
	get_volume
	;;
--up)
	pactl set-sink-volume @DEFAULT_SINK@ +2%
	send_notification up
	;;
--down)
	pactl set-sink-volume @DEFAULT_SINK@ -2%
	send_notification down
	;;
--mute)
	pactl set-sink-mute @DEFAULT_SINK@ toggle
	if [ "$(is_muted)" = "yes" ]; then
		dunstify \
			-i icons8-mute-53 \
			-a "pactl set-sink-volume @DEFAULT_SINK@" \
			-t 2000 \
			-r 9993 \
			-u low "Muted"
	else
		send_notification up
	fi
	;;
--gui)
	blueman-manager &
	;;
--icon)
	get_icon
	;;
*)
	dunstify -i icons8-mute-53 -a "volume.sh" -t 2000 -r 9993 -u low "Argument wrong"
	;;
esac
