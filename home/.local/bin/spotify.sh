#!/usr/bin/env bash

status=$(playerctl -p spotify status)

if [[ -z $status ]]; then
   exit
fi

artist=$(playerctl -p spotify metadata xesam:artist)
title=$(playerctl -p spotify metadata xesam:title)
album=$(playerctl -p spotify metadata xesam:album)

# Modify strings to avoid errors
artist="${artist/&/"&amp;"}"
title="${title/&/"&amp;"}"
album="${album/&/"&amp;"}"

if [[ $status == "Playing" ]]
then
   echo "{\"class\": \"playing\", \"text\": \"$artist - $title\", \"tooltip\": \"Playing: $artist - $title from $album\"}"
   # pkill -RTMIN+5 waybar
fi

if [[ $status == "Paused" ]]
then
   echo "{\"class\": \"paused\", \"text\": \"$artist - $title\", \"tooltip\": \"Paused: $artist - $title from $album\"}"
   # pkill -RTMIN+5 waybar
fi