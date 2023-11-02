
BOARD_NAME=$(head -n 1 /sys/devices/virtual/dmi/id/board_name)

function notification() {
    dunstify -i $1 "System detected" "$2" \
        -a "configuration.sh" -u hi -t 7500
}

case $BOARD_NAME in
    "ROG STRIX Z790-E GAMING WIFI")
        notification icons8-asus-64 "$BOARD_NAME"

        # NOTE: Default configuration, therefore no further changes necessary
    ;;
    "LENOVO")
        notification icons8-lenovo-48 "$BOARD_NAME"

        # Change monitor settings
        hyprctl keyword monitor DP-1,disable
        hyprctl keyword monitor DP-2,disable
        hyprctl keyword monitor eDP-2,prefered@60,auto,1

        # Use hyprpaper for static wallpaper (save resources)
        swww query && swww kill
        sleep 0.5
        hyprctl hyprpaper wallpaper "eDP-1,~/.local/share/backgrounds/regular/japanese-store.jpg"
        hyprctl hyprpaper wallpaper "HDMI-A-2,~/.local/share/backgrounds/regular/japanese-store.jpg"
    ;;
    *)
        dunstify -i icons8-motherboard-64 "System detection failed" \
            "System could not be identified. Please check ~/.local/bin/configuration.sh." \
            -a "configuration.sh" -u hi -t 7500
    ;;
esac



# HYPRGAMEMODE=$(hyprctl getoption animations:enabled | sed -n '2p' | awk '{print $2}')
# if [ "$HYPRGAMEMODE" = 1 ]; then

# 	# with scaling other than 1, no 4K resolution available in steam
# 	hyprctl keyword monitor DP-1,prefered@60,0x0,1
# 	hyprctl keyword monitor DP-2,disable

# 	# kill application for wallpaper
# 	# pkill swww
# 	# pkill waybar

# 	# disable fancy hyprland stuff
# 	hyprctl --batch "\
#         keyword animations:enabled 0;\
#         keyword decoration:drop_shadow 0;\
#         keyword decoration:blur 0;\
#         keyword general:gaps_in 0;\
#         keyword general:gaps_out 0;\
#         keyword general:border_size 1;\
#         keyword decoration:rounding 0" &&
# 		notify-send --icon="icons8-game-controller-80" --expire-time=3000 'Hyprland' '\nGamemode activated!'
# 	exit
# fi

# # hyprctl keyword monitor DP-1,prefered@60,0x0,2
# # hyprctl keyword monitor DP-2,disable
# hyprctl reload && notify-send --icon="icons8-game-controller-80" --expire-time=3000 'Hyprland' '\nGamemode deactivated!'
