#!/usr/bin/env bash


function get_volume() {
	echo "$(pamixer --get-volume)"
}

function is_muted() {
	echo "$(pactl get-sink-mute @DEFAULT_SINK@ | grep "Mute: " | cut -d " " -f 2)"
}

function get_icon() {
	if [ $(is_muted) = "yes" ]; then
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
	dunstify -u low -r "9993" -h int:value:"$volume" -i "volume-$1" "Volume: ${volume}%" -t 2000
}

case $1 in
	up)
		pactl set-sink-volume @DEFAULT_SINK@ +2%
		send_notification "$1"
		;;
	down)
		pactl set-sink-volume @DEFAULT_SINK@ -2%
		send_notification "$1"
		;;
	mute)
		pactl set-sink-mute @DEFAULT_SINK@ toggle
		if [ $(is_muted) = "yes" ]; then
			dunstify -i icons8-mute-53 -a "changevolume" -t 2000 -r 9993 -u low "Muted"
		else
			send_notification up
		fi
		;;
	icon)
		echo $(get_icon)
		;;
	*)
		dunstify -i icons8-mute-53 -a "changevolume" -t 2000 -r 9993 -u low "Argument wrong"
	;;
esac
