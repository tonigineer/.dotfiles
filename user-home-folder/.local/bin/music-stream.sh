#!/usr/bin/env bash

urls=(
    "https://www.youtube.com/watch?v=MVPTGNGiI-4&ab_channel=LofiGirl"
    "https://www.youtube.com/watch?v=R4l6RVxBxvk"
    "https://www.youtube.com/watch?v=cCTaiJZAZak"
)
num_urls=${#urls[@]}

current_title=$(ps aux | grep mpv | grep -oP '(?<=title=").*(?=")')

i=0
if [ ! -z "$current_title" ]; then
    echo "$current_title"
    title_found=""
    while [ -z "$title_found" ]
    do
        title_found=$(wget ${urls[${i}]} -q -O - | grep "${current_title}")
        i=$((i+1))
    done

    i=$((i % $num_urls))
    pkill mpv
fi

yt playurl "${urls[${i}]}"

next_title=""
while [ -z "$next_title" ]
do
    next_title=$(ps aux | grep mpv | grep -oP '(?<=title=").*(?=")')
    sleep 0.5
done
dunstify -i icons8-youtube-live-144 "Streaming" "Title: $next_title" -a Waybar -u hi -t 5000