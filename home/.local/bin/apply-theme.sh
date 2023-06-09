#!/usr/bin/env bash

# SOURCE: https://github.com/cybergaz/Hyprland_Rice

THEME_DIR=/usr/share/themes/
ICONS_DIR=/usr/share/icons/

# // ------ Apply themes ------ //
if [ "$1" = "theme" ]; then
    if [ "$2" = "current" ]; then
        echo $(gsettings get org.gnome.desktop.interface gtk-theme)
        exit 0
    fi

    if [ "$2" = "list" ]; then
        for folder in $THEME_DIR* ; do
            echo $folder
        done
        exit 0
    fi

    if [ -d "$THEME_DIR$2" ]; then
        gsettings set org.gnome.desktop.interface gtk-theme $2
        exit 0
    else
        echo No theme \"$2\" found in $THEME_DIR
        exit 1
    fi
fi

# // ------ Apply icons ------ //
if [ "$1" = "icons" ]; then
    if [ "$2" = "current" ]; then
        echo $(gsettings get org.gnome.desktop.interface icon-theme)
        exit 0
    fi

    if [ "$2" = "list" ]; then
        for folder in $ICONS_DIR* ; do
            echo $folder
        done
        exit 0
    fi

    if [ -d "$ICONS_DIR$2" ]; then
        gsettings set org.gnome.desktop.interface icon-theme $2
        exit 0
    else
        echo No icons \"$2\" found in $ICONS_DIR
        exit 1
    fi
fi

# // ------ Apply cursor ------ //
if [ "$1" = "cursor" ]; then
    if [ "$2" = "current" ]; then
        echo $(gsettings get org.gnome.desktop.interface cursor-theme)
        exit 0
    fi

    if [ "$2" = "list" ]; then
        for folder in $ICONS_DIR* ; do
            echo $folder
        done
        exit 0
    fi

    if [ -d "$ICONS_DIR$2" ]; then
        gsettings set org.gnome.desktop.interface cursor-theme $2
        exit 0
    else
        echo No cursor \"$2\" found in $ICONS_DIR
        exit 1
    fi
fi
