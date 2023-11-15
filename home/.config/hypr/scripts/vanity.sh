#!/usr/bin/env bash

THEME=$1
ICONS=$2
CURSOR=$3
CURSOR_SIZE=$4
FONT=$5

THEME_DIR=~/.local/share/themes
ICONS_DIR=~/.local/share/icons

mkdir -p $THEME_DIR $ICONS_DIR
mkdir -p ~/.config/gtk-3.0 ~/.config/gtk-4.0

# ---------------------------------------
# --------- Downloading themes ----------
# ---------------------------------------
case $THEME in
Tokyonight-Dark-BL-LB)
	if [[ ! -d $THEME_DIR/$THEME ]]; then
		git clone https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme "$THEME_DIR/${THEME}_REPO"
		mv "$THEME_DIR/${THEME}_REPO/themes/Tokyonight-Dark-BL-LB" "$THEME_DIR"
		rm -rf "$THEME_DIR/${THEME}_REPO"
	fi
	cp -rf "$THEME_DIR/$THEME/gtk-4.0" ~/.config/
	;;
*)
	dunstify -u critical -t 0 -i icons8-knowledge-64 "embrace-vanity.sh" "THEME: $THEME is not defined."
	exit
	;;
esac

case $ICONS in
candy-icons)
	[[ ! -d "$ICONS_DIR/$ICONS" ]] && git clone https://github.com/EliverLara/candy-icons "$ICONS_DIR/$ICONS"
	;;
*)
	dunstify -u critical -t 0 -i icons8-knowledge-64 "embrace-vanity.sh" "ICONS: $ICONS is not defined."
	exit
	;;
esac

case $CURSOR in
Bibata-Modern-*)
	if [[ ! -d $ICONS_DIR/$CURSOR ]]; then
		wget https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.4/"${CURSOR}".tar.xz -P "$ICONS_DIR"
		tar -xvf $ICONS_DIR/Bibata*.tar.xz -C "$ICONS_DIR"
		rm $ICONS_DIR/Bibata*.tar.xz
	fi
	;;
*)
	dunstify -u critical -t 0 -i icons8-knowledge-64 "embrace-vanity.sh" "CURSOR: $CURSOR is not defined."
	exit
	;;
esac

# ------------------------------------
# --------- Applying themes ----------
# ------------------------------------

# https://wiki.archlinux.org/title/GTK

# GTK 2
echo \
	"gtk-icon-theme-name = \"${ICONS}\"
gtk-theme-name = \"${THEME}\"
gtk-font-name = \"${FONT}\"
gtk-cursor-theme-name = \"${CURSOR}\"
gtk-cursor-theme-size = \"${CURSOR_SIZE}\"
" >~/.gtkrc-2.0

# GTK 3
echo \
	"[Settings]
gtk-icon-theme-name = ${ICONS}
gtk-theme-name = ${THEME}
gtk-font-name = ${FONT}
gtk-cursor-theme-name = ${CURSOR}
gtk-cursor-theme-size = ${CURSOR_SIZE}
gtk-application-prefer-dark-theme = true" >~/.config/gtk-3.0/settings.ini

# GTK 4
gsettings set org.gnome.desktop.interface gtk-theme "$THEME"
gsettings set org.gnome.desktop.interface icon-theme "$ICONS"
gsettings set org.gnome.desktop.interface cursor-theme "$CURSOR"
gsettings set org.gnome.desktop.interface cursor-size "$CURSOR_SIZE"
gsettings set org.gnome.desktop.interface font-name "$FONT"
gsettings set org.gnome.desktop.interface color-scheme prefer-dark

# Apply system wide
# ln -s "$HOME/.gtkrc-2.0" /etc/gtk-2.0/gtkrc
# ln -s "$HOME/.config/gtk-3.0/settings.ini" /etc/gtk-3.0/settings.ini
