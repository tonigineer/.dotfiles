#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
DOTS_DIR=$SCRIPT_DIR/user-home-folder  # remove last part of path

ADDITIONAL_DIRS=(
    .icons/default/index.theme
    .gtkrc-2.0
    .Xresources
    .local/bin
    .local/share/backgrounds
    .local/share/icons/dunst
    .local/share/sounds
)

# // ------ Sub-functions ----- //
link_dir(){
   SOURCE_DIR=$1
   TARGET_DIR=$2

    if [[ -e "$TARGET_DIR" ]]; then
        if [[ -L "$TARGET_DIR" ]]; then
            echo -e "\e[93m${SOURCE_DIR}\e[0m is already linked to \e[93m${TARGET_DIR}\e[0m."
            return
        else
            mv ${TARGET_DIR} ${TARGET_DIR}_backup
            echo -e "\e[91m${TARGET_DIR}\e[0m was backuped into \e[91m${TARGET_DIR}_backup\e[0m."
            rm -rf ${TARGET_DIR}
        fi
    fi
    ln -s $SOURCE_DIR $TARGET_DIR
    echo -e "Simlink for \e[92m${SOURCE_DIR}\e[0m to \e[92m${TARGET_DIR}\e[0m was created."
}

# // ------ Link additional dirs ------ //
for dir in "${ADDITIONAL_DIRS[@]}"; do
    SOURCE_DIR=$DOTS_DIR/$dir
    TARGET_DIR=~/$dir

    link_dir $SOURCE_DIR $TARGET_DIR
done

# // ------ Link folder in ~/.config ------ //
for folder in $(\ls $DOTS_DIR/.config); do
    SOURCE_DIR=$DOTS_DIR/.config/$folder
    TARGET_DIR=~/.config/$folder

    link_dir $SOURCE_DIR $TARGET_DIR
done

exit 0