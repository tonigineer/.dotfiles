#!/usr/bin/env bash

CONTROLLER_MAC="EC:83:50:9E:74:0F"

check_controller_connection() {
    if bluetoothctl info "$CONTROLLER_MAC" | grep -q "Connected: yes"; then
        echo true
    else
        echo false
    fi
}

connect_controller() {
    alacritty --title "float" -e "bluetoothctl"
}

case "$1" in
    check)
        check_controller_connection
        ;;
    connect)
        connect_controller
        ;;
    *)
        echo "Usage: $0 {check|connect}"
        exit 1
        ;;
esac
