#!/usr/bin/env bash

if [ $1 = "cpu-temp" ]; then
    CPU_TEMP=$(expr $(cat /sys/class/thermal/thermal_zone*/temp | sed -n '2 p') / 1000)

    if [ "$CPU_TEMP" -ge "65" ]; then
        TEMP_CLASS="critical"
        CPU_TEMP=" "$CPU_TEMP
    elif [ "$CPU_TEMP" -ge "45" ]; then
        TEMP_CLASS="load"
        CPU_TEMP=" "$CPU_TEMP
    else
        TEMP_CLASS="idle"
        CPU_TEMP=" "$CPU_TEMP
    fi

    echo "{\"text\":\"${CPU_TEMP}°C\", \"tooltip\":\"CPU temperature\n<i>/sys/class/thermal/thermal_zone*/temp</i>\", \"class\": \"${TEMP_CLASS}\"}"
fi