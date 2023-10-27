#!/usr/bin/env bash

WALLPAPER_DIR=~/.local/share/backgrounds/.loop

# Determine necessay information
wallpaper_avail=("$WALLPAPER_DIR"/*)
wallpaper_number=${#wallpaper_avail[@]}

if [[ "$wallpaper_number" -le "0" ]]; then
	dunstify -u critical -t 0 -i icons8-knowledge-64 "wallpaper.sh" "No wallpaper found in ~/.local/share/background/.loop"
	exit
fi

wallpaper_current=$(swww query | grep -o '[^ ]*$' | head -1 | rev | cut -d "/" -f1 | rev)

tooltip_string="<b><i>Change wallpaper</i></b>\n"
i=0
for f in "${wallpaper_avail[@]}"; do
	filename="${f##*/}"
	if [ "$filename" = "$wallpaper_current" ]; then
		filename="<b> $filename</b>"
		wallpaper_prev=${wallpaper_avail[$(((i - 1) % wallpaper_number))]}
		wallpaper_next=${wallpaper_avail[$(((i + 1) % wallpaper_number))]}
	else
		filename=" $filename"
	fi

	tooltip_string="$tooltip_string$filename"

	i=$((i + 1))
	if ((i < wallpaper_number)); then
		tooltip_string="$tooltip_string\n"
	fi
done

function get_random_animation() {
	array[0]="--transition-fps 120 --transition-duration 1.75 --transition-type grow --transition-pos 0.925,0.975 --transition-bezier 0.4,1.1,0.4,0.2"
	array[1]="--transition-fps 120 --transition-duration 1.75 --transition-type grow --transition-pos 0.075,0.975 --transition-bezier 0.4,1.1,0.4,0.2"

	size=${#array[@]}
	index=$((RANDOM % size))
	echo "${array[$index]}"
}

function reset_daemon() {
	sleep 0.1
	swww query && swww kill
	swww init
}

function apply_wall() {
	if [ "$2" = "silent" ]; then
		swww img "$1" $(get_random_animation)
	else
		current_workspace=$(hyprctl activewindow | grep workspace | grep -oP '(?<=workspace: ).*(?= )')
		sleep_duration=$(grep -oP '(?<=--transition-duration ).*(?= --transition-type)' <<<"$(get_random_animation)")

		hyprctl dispatch workspace 9

		swww img "$1" $(get_random_animation)
		dunstify -i icons8-wallpaper-64 "Wallpaper updated" "Changed to ${1##*/}" -a Waybar -u low -t 2000

		sleep "$sleep_duration"
		hyprctl dispatch workspace "$current_workspace"
	fi
}

# Actual function calls with argument
if [ "$1" = "tooltip" ]; then
	echo '{"text": "󰸉", "tooltip": "'"${tooltip_string}"'"}'
	exit 0
fi

if [ "$1" = "reset" ]; then
	reset_daemon
fi

if [ "$1" = "next" ]; then
	apply_wall "$wallpaper_next" "$2"
fi

if [ "$1" = "prev" ]; then
	apply_wall "$wallpaper_prev" "$2"
fi
