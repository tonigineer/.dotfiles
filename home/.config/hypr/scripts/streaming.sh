#!/usr/bin/env bash

function kill_mpv() {
	ps aux | grep mpv | grep -E -v "mpvpaper" | awk '{print $2}' | xargs kill -9
}

case $1 in
--music)
	urls=(
		"https://www.youtube.com/watch?v=6UM5oAoK8L8&t=899s"
		"https://www.youtube.com/watch?v=LxQWv-p5BMQ"
		"https://www.youtube.com/watch?v=SFS5Z2UNMps"
		"https://www.youtube.com/watch?v=D1zR9DkYgu4"
		"https://www.youtube.com/watch?v=fKvdh98KKSs"
		"https://www.youtube.com/watch?v=g6hY7dB54bc"
		"https://www.youtube.com/watch?v=cCTaiJZAZak"
		# "https://www.youtube.com/watch?v=MVPTGNGiI-4&ab_channel=LofiGirl"  # currently offline
	)
	;;
--orf)
	urls=(
		"https://zdf-hls-19.akamaized.net/hls/live/2016502/de/high/master.m3u8"
		"https://www.zdf.de/sender/zdf/zdf-live-beitrag-100.html"
		"https://mcdn.daserste.de/daserste/de/master.m3u8"
	)
	;;
esac

num_urls=${#urls[@]}
current_url="$(ps aux | grep mpv | grep -oP '(?<=https://).*(?=)')"

# Catch change between different lists
if [[ ! "$(echo "${urls[@]}" | grep -F "$current_url")" ]]; then
	current_url=""
	kill_mpv
fi

if [ -n "$current_url" ]; then
	current_url="https://$current_url"

	i=0
	while [ ! "${urls[${i}]}" = "$current_url" ]; do
		i=$((i + 1))
		i=$((i % num_urls))
	done

	i=$((i + 1))
	i=$((i % num_urls))

	kill_mpv
fi

current_title=$(yt-dlp --get-title "${urls[${i}]}")
dunstify \
	-i icons8-youtube-live-144 \
	"$([ "$1" = "--music" ] && echo "Music" || echo "Video")" \
	"Title: $current_title" \
	-a "Streaming Script" \
	-u normal \
	-t 5000

mpv "${urls[${i}]}"
