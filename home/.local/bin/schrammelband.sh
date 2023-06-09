#!/usr/bin/env sh

MACADDRESS="88:C6:26:C9:C2:65"
NAME="SCHRAMMELBAND"

if [ -z "$1" ]; then
    echo Not argument given, use connect, status or reset.
    exit 1
fi

blue_out=$(bluetoothctl devices | cut -f2 -d' ' | while read uuid; do bluetoothctl info $uuid; done|grep -e "Device\|Connected\|Name")
connected=0
if grep -q "Name: ${NAME}" <<< "$blue_out"; then
    if grep -q "Connected: yes" <<< "$blue_out"; then
        connected=1
    fi
fi

if [ "$1" = "status" ]; then
    if [ "$connected" = 0 ]; then
        echo '{"text":"󰓃","tooltip":"SCHRAMMELBAND not connected"}'
    else
        echo '{"text":"󰦢","tooltip":"SCHRAMMELBAND connected"}'
    fi
    exit 0
fi

if [ "$1" = "connect" ]; then
    if [ "$connected" = 0 ]; then
        bluetoothctl connect $MACADDRESS
    else
        bluetoothctl disconnect $MACADDRESS
    fi
    exit 0
fi

# bluetoothctl remove $MACADDRESS





# bluetoothctl paired-devices | cut -f2 -d' '|
# while read -r uuid
# do
#     info=`bluetoothctl info $uuid`
#     if echo "$info" | grep -q "Connected: yes"; then
#        echo "$info" | grep "Name"
#     fi
# done