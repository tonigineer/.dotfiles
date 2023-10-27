#!/usr/bin/env bash

if [ "$1" = "music" ]; then
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
fi

if [ "$1" = "orf" ]; then
	urls=(
		"https://zdf-hls-19.akamaized.net/hls/live/2016502/de/high/master.m3u8"
		"https://www.zdf.de/sender/zdf/zdf-live-beitrag-100.html"
		"https://mcdn.daserste.de/daserste/de/master.m3u8"
	)
fi

num_urls=${#urls[@]}
current_url="$(ps aux | grep mpv | grep -oP '(?<=https://).*(?=)')"

if [ -n "$current_url" ]; then
	current_url="https://$current_url"

	i=0
	while [ ! "${urls[${i}]}" = "$current_url" ]; do
		i=$((i + 1))
		i=$((i % num_urls))
	done

	i=$((i + 1))
	i=$((i % num_urls))

	pkill mpv
fi

current_title=$(yt-dlp --get-title "${urls[${i}]}")
dunstify -i icons8-youtube-live-144 "Streaming" "Title: $current_title" -a Waybar -u hi -t 5000

mpv "${urls[${i}]}"
