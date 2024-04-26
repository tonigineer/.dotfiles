#!/usr/bin/env bash

mode=$1
header=$2
message=$3
sender=$4
icon=$5
timeout=$6
priority=$7

[ "$icon" = "" ] && icon=icons8-brick-game-53_light

case $mode in
--low)
	dunstify -u \
		-a "$sender" \
		-i "$icon" \
		"$header" \
		"$message"
	;;
--normal)
	dunstify -u \
		-a "$sender" \
		-i "$icon" \
		"$header" \
		"$message"
	;;
--critical)
	dunstify -u critical \
		-a "$sender" \
		-i "$icon" \
		"$header" \
		"$message"
	;;
--custom)
	dunstify -u "$priority" \
		-t "$timeout" \
		-a "$sender" \
		-i "$icon" \
		"$header" \
		"$message"
	;;
"")
	echo \
		"Examples:
notification --low Header Message Sender Icon
notification --normal Header Message Sender Icon
notification --critical Header Message Sender Icon
notification --custom Header Message Sender Icon Timeout Priority

Icon-Dir: ~/.local/share/icons/dunst
"
	;;
esac
