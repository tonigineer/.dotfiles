#!/usr/bin/env bash

# https://wiki.archlinux.org/title/PipeWire#Audio
#
# NOTE: Script applies command to all input sinks. This bullshit
# is needed, since my speakers does not work properly via pavucontrol.
# !!! Script now changed to DEFAULT_SINK

is_muted() {
	pactl get-sink-mute @DEFAULT_SINK@ | grep "Mute: " | cut -d " " -f 2

	# pactl list sink-inputs | grep Mute: | head -1 | cut -d ' ' -f2 | sed -e 's/[^a-zA-Z]//g'
}

# set() {
# 	volume=$1
# 	echo $volume
# 	pactl list sink-inputs | grep "Sink Input" | while read line; do
# 		sink=$(echo "$line" | sed -rn 's/^Sink Input #(.*)/\1/p')
# 		if [ "$sink" != "" ]; then
# 			pactl set-sink-input-volume "$sink" "$volume"%
# 		fi
# 	done
# }

volume() {
	pactl get-sink-volume @DEFAULT_SINK@ | grep -o -P '[0-9]*(\.[0-9]*)?(?=%)' | head -1

	# printf "%02d\n" $(pamixer --get-volume)
	# pactl list sink-inputs |
	# 	grep Volume |
	# 	cut -d '/' -f2 |
	# 	sed -e 's/[^0-9]//g' | awk 'END { print min }
	#                                    {
	#                                        min || min = $1
	#                                        $1 < min && min = NR
	#                                    }'
}

up() {
	pactl set-sink-volume @DEFAULT_SINK@ +2%

	# pactl list sink-inputs | grep "Sink Input" | while read line; do
	# 	sink=$(echo "$line" | sed -rn 's/^Sink Input #(.*)/\1/p')
	# 	if [ "$sink" != "" ]; then
	# 		pactl set-sink-input-volume "$sink" +5%
	# 	fi
	# done

	if pgrep -x "eww" >/dev/null; then
		~/.config/eww/notify/scripts/volume.sh
	fi
}

down() {
	pactl set-sink-volume @DEFAULT_SINK@ -2%

	# pactl list sink-inputs | grep "Sink Input" | while read line; do
	# 	sink=$(echo "$line" | sed -rn 's/^Sink Input #(.*)/\1/p')
	# 	if [ "$sink" != "" ]; then
	# 		pactl set-sink-input-volume "$sink" -5%
	# 	fi
	# done

	if pgrep -x "eww" >/dev/null; then
		~/.config/eww/notify/scripts/volume.sh
	fi
}

mute_toggle() {
	pactl set-sink-mute @DEFAULT_SINK@ toggle

	# pactl list sink-inputs | grep "Sink Input" | while read line; do
	# 	sink=$(echo "$line" | sed -rn 's/^Sink Input #(.*)/\1/p')
	# 	if [ "$sink" != "" ]; then
	# 		pactl set-sink-input-mute "$sink" toggle
	# 	fi
	# done
}

case $1 in
--up | -u)
	up
	;;
--down | -d)
	down
	;;
--mute | -m)
	mute_toggle
	;;
--gui | -g)
	pavucontrol
	;;
--volume | -v)
	volume
	;;
# --equal-sink | -es)
# 	set "$(volume)"
# 	;;
--is-muted | -im)
	is_muted
	;;
esac
