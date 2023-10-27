#!/usr/bin/env bash

cd "$(dirname "$0")" || exit
REPO_DIR=$(git rev-parse --show-toplevel)

source "$REPO_DIR/scripts/coloring.sh"

TASKS=(
	"bluetooth"
	"nerdfonts"
	"thunar"
)

function fnc_bluetooth() {
	# MEMORY: ~ bluetoothctl
	if [[ "$1" = "status" ]]; then
		[[ "$(systemctl is-active "bluetooth.service")" = "active" ]] && echo "" || echo ""
		return
	fi

	if [[ "$1" = "install" ]]; then
		lsmod | grep btusb # check if bluetooth module is loaded (should appear on list)
		modprobe btusb     # exec if not loaded
		systemctl enable bluetooth.service
	fi
}

function fnc_nerdfonts() {
	# MEMORY: ~ fc-list | grep Casca

	if [[ "$1" = "status" ]]; then
		[[ -f "/usr/bin/getnf" ]] && echo "" || echo ""
	fi

	if [[ "$1" = "install" ]]; then
		git clone https://github.com/ronniedroid/getnf /tmp/getnf
		sudo mv /tmp/getnf/getnf /usr/bin/
		rm -rf /tmp/getnf
	fi
}

function fnc_thunar() {
	if [[ "$1" = "status" ]]; then
		[[ ! "$(yay -Q | grep thunar-volman)" = "" ]] && echo "" || echo ""
		return
	fi

	if [[ "$1" = "install" ]]; then
		yay -S thunar thunar-volman gvfs-git xdg-user-dirs tumbler
		xdg-user-dirs-update
	fi
}

while "true"; do
	clear

	C_TASKS=("${TASKS[@]}")
	for i in "${!C_TASKS[@]}"; do
		C_TASKS[i]="$(fnc_"${TASKS[$i]}" "status") ${C_TASKS[i]}"
	done

	color " INSTALLATION STATUS\n" magenta
	PS3="Select post-installation task: "
	select opt in "󰩈 Exit" "${C_TASKS[@]}"; do
		case $opt in
		*Exit*)
			exit
			;;
		*)
			# Loop over all tasks and check if opt matches
			# this makes sure, only valid inputs are used
			for key in "${!C_TASKS[@]}"; do
				if [ "${C_TASKS[$key]}" = "$opt" ]; then
					fnc_"${TASKS[key]}" "install"
				fi
			done
			;;
		esac
		break
	done
done
