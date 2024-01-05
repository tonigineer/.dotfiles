#!/usr/bin/env bash

# ! Interesting with Rofi-Menu: https://gist.github.com/miyl/40cdf1a66b360ad8ec0b19e2ffa56194

# // Hardcoded device for machine
HEADSET="alsa_output.usb-Plantronics_Poly_BT600_24620504a7154d73bcc85e50e4a997c6-00.5.analog-stereo"
BLUETOOTH_SPEAKER="bluez_output.88_C6_26_C9_C2_65.1"

HEADSET_SHORTNAME="PT600"
BLUETOOTH_SPEAKER_SHORTNAME="SCHRAMMELBAND"

HEADSET_ICON="󰋋"
BLUETOOTH_SPEAKER_ICON="󰦢"

AVAILABLE_OUTPUTS=""

# ============================================================
# ------------------------- HELPER ---------------------------
# ============================================================
function _get_default_sink() {
	echo $(pactl info | grep 'Default Sink' | cut -d':' -f 2)
}

function _set_default_sink() {
	pactl set-default-sink "$1"
}

function _default_sink_is_muted() {
	pactl get-sink-mute @DEFAULT_SINK@ | grep "Mute: " | cut -d " " -f 2
}

function _get_volume() {
	printf "%02d\n" $(pamixer --get-volume)
}

function _send_notification() {
	volume=$(_get_volume)
	dunstify \
		-u low \
		-a "pactl set-sink-volume @DEFAULT_SINK@" \
		-r "9993" \
		-h int:value:"$volume" \
		-i "volume-$1" "Volume: ${volume}%" \
		-t 2000
}

# ============================================================
# ------------------- ARGUMENT FUNCTIONS ---------------------
# ============================================================
function get_output_icon() {
	case $(_get_default_sink) in
		$HEADSET)
			case $(_default_sink_is_muted) in
			"no")
				echo $HEADSET_ICON
				;;
			"yes")
				echo ""
				;;
			esac
			;;
		$BLUETOOTH_SPEAKER)
			case $(_default_sink_is_muted) in
			"no")
				echo $BLUETOOTH_SPEAKER_ICON
				;;
			"yes")
				echo ""
				;;
			esac
			;;
		*)
			echo "󰓄"
			;;
	esac
}

function get_output_name() {
	case $(_get_default_sink) in
		$HEADSET)
			echo $HEADSET_SHORTNAME
		;;
		$BLUETOOTH_SPEAKER)
			echo $BLUETOOTH_SPEAKER_SHORTNAME
		;;
		*)
			echo "NA"
		;;
	esac
}

function toggle_output() {
	# TODO: Toggle through a list of defined outputs
	case $(_get_default_sink) in
	$HEADSET)
		_set_default_sink "$BLUETOOTH_SPEAKER"
	;;
	$BLUETOOTH_SPEAKER)
		_set_default_sink "$HEADSET"
	;;
	esac
}

function _send_notification() {
	volume=$(_get_volume)
	dunstify \
		-u low \
		-a "pactl set-sink-volume @DEFAULT_SINK@" \
		-r "9993" \
		-h int:value:"$volume" \
		-i "volume-$1" "Volume: ${volume}%" \
		-t 2000
}

case $1 in
--get-volume)
	_get_volume
	;;
--up)
	pactl set-sink-volume @DEFAULT_SINK@ +2%
	_send_notification up
	;;
--down)
	pactl set-sink-volume @DEFAULT_SINK@ -2%
	_send_notification down
	;;
--mute)
	pactl set-sink-mute @DEFAULT_SINK@ toggle
	if [ "$(_default_sink_is_muted)" = "yes" ]; then
		dunstify \
			-i icons8-mute-53 \
			-a "pactl set-sink-volume @DEFAULT_SINK@" \
			-t 2000 \
			-r 9993 \
			-u low "Muted"
	else
		_send_notification up
	fi
	;;
--toggle-output)
	toggle_output &
	;;
--output-icon)
	get_output_icon &
	;;
--output-name)
	get_output_name &
	;;
--blueman-manager-gui|-btgui)
	blueman-manager &
	;;
--pavucontrol-gui|-pavugui)
	pavucontrol &
	;;
*)
	dunstify -i icons8-mute-53 -a "volume.sh" -t 2000 -r 9993 -u low "Argument wrong"
	;;
esac
