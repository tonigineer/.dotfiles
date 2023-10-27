#!/usr/bin/env bash

cd "$(dirname "$0")" || exit
REPO_DIR=$(git rev-parse --show-toplevel)

source "$REPO_DIR/scripts/coloring.sh"

function show_package_status() {
	yay -Q >"/tmp/packages.lst"
	clear

	echo "$(color " INSTALLATION STATUS" magenta)"
	while read -r package; do
		ver=$(grep -R "$package " "/tmp/packages.lst" | head -1)
		[[ -z "$ver" ]] &&
			echo "$(color "" red) ${package}" ||
			echo "$(color "" green) $(echo "$ver" | cut -d " " -f1) $(color "${ver##* }" white)"
	done <"$1"

	rm "/tmp/packages.lst"
}

while "true"; do
	clear

	PS3="Select installation part: "
	select option in "󰩈 Exit" "󱧘 Packages - essentials" "󱧘 Packages - hyprland" " Symlink configuration" "󰓬 Post-Installation" " Install NerdFonts"; do
		case $option in
		*Exit*)
			exit
			;;
		*Packages*essentials*)
			show_package_status "$REPO_DIR/essentials.lst"

			echo ""
			PS3="Install $(color essentials.lst magenta): "
			select yn in Yes No; do
				case $yn in
				Yes)
					yay -S - <"$REPO_DIR/essentials.lst"
					break
					;;
				No) break ;;
				esac
			done
			break
			;;
		*Packages*hyprland*)
			show_package_status "$REPO_DIR/hyprland.lst"

			echo ""
			PS3="Install $(color hyprland.lst magenta): "
			select yn in Yes No; do
				case $yn in
				Yes)
					yay -S - <"$REPO_DIR/hyprland.lst"
					break
					;;
				No) break ;;
				esac
			done
			break
			;;
		*Symlink*configuration*)
			"$REPO_DIR/scripts/symlink-config.sh"
			break
			;;
		*Post*Installation*)
			# Thunar
			"$REPO_DIR/scripts/post-installation.sh"
			break
			;;
		*Install*NerdFonts*)
			# Thunar
			/usr/bin/getnf
			break
			;;
		esac
	done
done
