#!/usr/bin/env bash

if [ "$1" = "cpu-temp" ]; then
	CPU_TEMP=$(($(cat /sys/class/thermal/thermal_zone*/temp | sort -nr | sed -n '1 p') / 1000))

	if [ "$CPU_TEMP" -ge "65" ]; then
		TEMP_CLASS="critical"
		ICON=""
	elif [ "$CPU_TEMP" -ge "45" ]; then
		TEMP_CLASS="load"
		ICON=""
	else
		TEMP_CLASS="idle"
		ICON=""
	fi

	echo "{\"text\":\"${ICON}\", \"tooltip\":\"CPU temperature\n<i>/sys/class/thermal/thermal_zone*/temp</i>\", \"class\": \"${TEMP_CLASS}\", \"percentage\": ${CPU_TEMP}}"
fi
