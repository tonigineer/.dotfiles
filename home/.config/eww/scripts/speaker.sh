#!/usr/bin/env bash

DEFAULT_DEVICE=88:C6:26:C9:C2:65 # SCHRAMMELBAND

function status() {
	present=$(bluetoothctl devices | grep $DEFAULT_DEVICE)
	if [ "$present" = "" ]; then
		echo "󰂯"
		exit 0
	fi

	device_info=$(bluetoothctl info ${DEFAULT_DEVICE})

	connected=$(echo "${device_info}" | grep "Connected:" | cut -f2 -d " ")
	if [ "$connected" = "yes" ];then
		echo "󰦢"
		exit 0
	fi

	trusted=$(echo "${device_info}" | grep "Trusted:" | cut -f2 -d " ")
	paired=$(echo "${device_info}" | grep "Paired:" | cut -f2 -d " ")
	if [ "$paired" = "yes" ]; then
		echo "󰓃"
		exit 0
	fi

	echo "󰓄"
}

function connect() {
	present=$(bluetoothctl devices | grep $DEFAULT_DEVICE)
	if [ "$present" = "" ]; then
		bluetoothctl -t 10 scan on
		exit 0
	fi

	device_info=$(bluetoothctl info ${DEFAULT_DEVICE})

	connected=$(echo "${device_info}" | grep "Connected:" | cut -f2 -d " ")
	if [ "$connected" = "yes" ];then
		exit 0
	fi

	trusted=$(echo "${device_info}" | grep "Trusted:" | cut -f2 -d " ")
	paired=$(echo "${device_info}" | grep "Paired:" | cut -f2 -d " ")	
	if [ "$paired" = "yes" ]; then
		bluetoothctl connect $DEFAULT_DEVICE
		exit 0
	fi

	# if [ "$trusted" = "yes" ]; then
	# 	bluetoothctl remove $DEFAULT_DEVICE
	# 	sleep 2
	# fi

	bluetoothctl trust $DEFAULT_DEVICE
	sleep 2
	bluetoothctl pair $DEFAULT_DEVICE
}



case $1 in
--icon)
	status
	;;
--connect)
	connect
	;;
*)
	echo "First argument must be \`--connect\`."
	;;
esac
