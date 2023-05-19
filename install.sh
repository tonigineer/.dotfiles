#!/usr/bin/env bash


# // ------ Installation ------ //

# Needed packages
yay -S --answerclean None --answerdiff None --needed - < packages.lst

# Fonts
yay -S --needed ttf-terminus-nerd ttf-cascadia-code-nerd
fc-cache -v

# Folder
xdg-user-dirs-update

# Appearance stuff
cd ~/Downloads
wget https://ppload-com.s3.eu-central-1.amazonaws.com/data/files/1580555858/volantes-light-cursors.tar.gz?response-content-disposition=attachment%3B%2520volantes-light-cursors.tar.gz&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIATLQUPBWASZL2ZPWI%2F20230510%2Feu-central-1%2Fs3%2Faws4_request&X-Amz-Date=20230510T195654Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Signature=05e90bdedabd8bcdfbe5616832d02c00183420b4739acb977a0ff24673bb9f49
tar -zxvf volantes-light-cursors.tar.gz
git clone https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme
sudo cp -r ~/Downloads/volantes_light_cursors /usr/share/icons
sudo cp -r Tokyo-Night-GTK-Theme/icons/Tokyonight-Moon /usr/share/icons
sudo cp -r Tokyo-Night-GTK-Theme/themes/Tokyonight-Dark-BL-LB /usr/share/themes
sudo cp -r Tokyo-Night-GTK-Theme/themes/Tokyonight-Dark-BL-LB/gtk-4.0 ~/.config
rm -rf volantes_light_cursors Tokyo-Night-GTK-Theme

# Settings
gsettings set org.cinnamon.desktop.default-applications.terminal exec alacritty


# // ------ Link all configuration files ------ //
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
DOTS_DIR=$SCRIPT_DIR/user-home-folder  # remove last part of path

ADDITIONAL_DIRS=(
    .bash_profile
    .icons/default/index.theme
    .local/bin
    .local/share/backgrounds
    .local/share/icons/dunst
    .local/share/sounds
)

mkdir -p ~/.icons/default
mkdir -p ~/.local/share/icons

# Sub-functions
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

# Link additional dirs
for dir in "${ADDITIONAL_DIRS[@]}"; do
    SOURCE_DIR=$DOTS_DIR/$dir
    TARGET_DIR=~/$dir

    link_dir $SOURCE_DIR $TARGET_DIR
done

# Link folder in ~/.config
for folder in $(\ls $DOTS_DIR/.config); do
    SOURCE_DIR=$DOTS_DIR/.config/$folder
    TARGET_DIR=~/.config/$folder

    link_dir $SOURCE_DIR $TARGET_DIR
done

exit 0