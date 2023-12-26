#!/usr/bin/env bash

LIVE_DIR=~/.local/share/backgrounds/live
REGULAR_DIR=~/.local/share/backgrounds/regular
GIF_DIR=~/.local/share/backgrounds/animated

function cycle_files() {
	dir=$1
	inc=$2

	if [ ! -f $dir/.index.lock ]; then
		touch $dir/.index.lock
		idx=-1
	else
		idx=$(head -n 1 $dir/.index.lock)
	fi

	files=($dir/*)
	idx=$(((idx + inc) % ${#files[@]}))
	echo $idx >$dir/.index.lock

	echo ${files[idx]}
}

function swww_reset() {
	pkill hyprpaper
	pkill mpvpaper
	swww kill
	swww init
}

function swww_apply() {
	swww img "$1" $(get_random_animation) # no quotes here!
}

function get_random_animation() {
	array[0]="--transition-fps 120 --transition-duration 0.75 --transition-type grow --transition-pos 0.925,0.975 --transition-bezier 0.4,1.1,0.4,0.2"
	array[1]="--transition-fps 120 --transition-duration 0.75 --transition-type grow --transition-pos 0.075,0.975 --transition-bezier 0.4,1.1,0.4,0.2"

	size=${#array[@]}
	index=$((RANDOM % size))
	echo "${array[$index]}"
}

function mpvpaper_reset() {
	pkill hyprpaper
	pkill swww
	pkill mpvpaper
}

function mpvpaper_apply() {
	pkill mpvpaper
	mpvpaper -p -f -o --loop DP-1 $1
	mpvpaper -p -f -o --loop DP-2 $1
}

case $1 in
--swww-animation)
	case $2 in
	--reset)
		file=$(cycle_files $GIF_DIR "0")
		swww_reset
		;;
	--next|down)
		file=$(cycle_files $GIF_DIR "1")
		;;
	--prev|up)
		file=$(cycle_files $GIF_DIR "-1")
		;;
	*)
		echo "Second argument must be either \`--reset\`, \`--next\` or \`--prev\`."
		exit 1
		;;
	esac
	swww_apply $file
	;;
--swww-regular)
	echo "regular"
	case $2 in
	--reset)
		file=$(cycle_files $REGULAR_DIR "0")
		swww_reset
		;;
	--next|down)
		file=$(cycle_files $REGULAR_DIR "1")
		echo "next"
		;;
	--prev|up)
		file=$(cycle_files $REGULAR_DIR "-1")
		;;
	*)
		echo "Second argument must be either \`--reset\`, \`--next\` or \`--prev\`."
		exit 1
		;;
	esac
	swww_apply $file
	;;
--mpvpaper)
	case $2 in
	--reset)
		file=$(cycle_files $LIVE_DIR "0")
		mpvpaper_reset
		;;
	--next|down)
		file=$(cycle_files $LIVE_DIR "1")
		;;
	--prev|up)
		file=$(cycle_files $LIVE_DIR "-1")
		;;
	*)
		echo "Second argument must be either \`--reset\`, \`--next\` or \`--prev\`."
		exit 1
		;;
	esac
	mpvpaper_apply $file
	;;
--eww)
	case $2 in
	0)
		mpvpaper_reset
		file=$(cycle_files $LIVE_DIR "0")
		mpvpaper_apply $file
		;;
	1)
		swww_reset
		file=$(cycle_files $GIF_DIR "0")
		swww_apply $file
		;;
	2)
		swww_reset
		file=$(cycle_files $REGULAR_DIR "0")
		swww_apply $file
		;;
	*)
		echo "Second argument must be either \`--reset\`, \`--next\` or \`--prev\`."
		exit 1
		;;
	esac
	;;
*)
	echo "First argument must be either \`--swww-animation\`, \`--swww-regular\` or \`--mpvpaper\`."
	exit 1
	;;
esac
