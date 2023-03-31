#!/usr/bin/env bash

status=$(playerctl -p spotify status)
artist=$(playerctl -p spotify metadata xesam:artist)
title=$(playerctl -p spotify metadata xesam:title)
album=$(playerctl -p spotify metadata xesam:album)

# Modify strings to avoid errors
artist="${artist/&/"&amp;"}"
title="${title/&/"&amp;"}"
album="${album/&/"&amp;"}"X

if [[ -z $status ]] 
then
   # spotify is dead, we should die to.
   exit
fi

if [[ $status == "Playing" ]]
then
   echo "{\"class\": \"playing\", \"text\": \"  $artist - $title\", \"tooltip\": \"Playing: $artist - $title | $album\"}"
   pkill -RTMIN+5 waybar
   exit
fi

if [[ $status == "Paused" ]]
then
   echo "{\"class\": \"paused\", \"text\": \"  $artist - $title\", \"tooltip\": \"Paused: $artist - $title | $album\"}"
   pkill -RTMIN+5 waybar
   exit
fi

