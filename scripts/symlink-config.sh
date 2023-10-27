#!/usr/bin/env bash

LINKS=(
	".config/alacritty"
	".config/btop"
	".config/cava"
	".config/dunst"
	".config/hypr"
	".config/mpv"
	".config/neofetch"
	".config/rofi"
	".config/swaylock"
	".config/waybar"
	".config/wlogout"

	".local/bin"
	".local/share/backgrounds"
	".local/share/icons/dunst"
	".local/share/sounds"

	".bash_profile"
	".bash_aliases"

	".config/nvim"
	".config/zsh"
)

mkdir -p ~/.local/share/icons

cd "$(dirname "$0")" || exit
REPO_DIR=$(git rev-parse --show-toplevel)

source "$REPO_DIR/scripts/coloring.sh"

function target_dir() { echo "/home/$USER/$1"; }
function source_dir() { echo "$REPO_DIR/home/$1"; }

create_symlink() {
	SOURCE=$(source_dir "$1")
	TARGET=$(target_dir "$1")

	if [[ (-f "$TARGET" || -d "$TARGET") && ! -L "$TARGET" ]]; then
		mv "${TARGET}" "${TARGET}_backup"
		echo -e "$(color  red) $(color "${TARGET}" magenta) was backuped into $(color "${TARGET}_backup" white)"
	fi

	if [[ -L "$TARGET" ]]; then
		if [ ! "$(readlink -- "$TARGET")" = "$SOURCE" ]; then
			echo -e "$(color  yellow) Symlink for $(color "${SOURCE}" white) exists, but from different target"
			rm "${TARGET}"
		else
			echo -e "$(color  green)  $(color "${SOURCE}" white) is already linked to $(color "${TARGET}" white)"
			return
		fi
	fi
	echo -e "$(color  green) Symlink for $(color "${SOURCE}" white) to $(color "${TARGET}" white) was created"
	ln -s "$SOURCE" "$TARGET"
}

while "true"; do
	clear

	C_LINKS=("${LINKS[@]}")
	for i in "${!C_LINKS[@]}"; do
		TARGET=$(target_dir "${C_LINKS[$i]}")
		SOURCE=$(source_dir "${C_LINKS[$i]}")

		[[ -L "$TARGET" ]] && [ "$(readlink -- "$TARGET")" = "$SOURCE" ] &&
			C_LINKS[i]=" ${C_LINKS[i]}" || C_LINKS[i]=" ${C_LINKS[i]}"
	done

	PS3="Symlink configuration: "
	select opt in "󰩈 Exit" " Link all" "${C_LINKS[@]}"; do
		case $opt in
		*Exit*)
			exit
			;;
		*Link*all*)
			for key in "${!LINKS[@]}"; do
				create_symlink "${LINKS[$key]}"
			done
			;;
		*)
			# Loop over all tasks and check if opt matches
			# this makes sure, only valid inputs are used
			for key in "${!C_LINKS[@]}"; do
				if [ "${C_LINKS[$key]}" = "$opt" ]; then
					create_symlink "${LINKS["$key"]}"
				fi
			done
			;;
		esac
		echo "Press any key to continue..."
		read -s -n 1
		break
	done
done
