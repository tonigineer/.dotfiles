#!/usr/bin/env bash

if [ ! -d ~/.config ]; then
    echo -e "\e[91mDirectory ~/.config does not exist, but was created.\e[0m."
    mkdir ~/.config
fi

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR


install_basics() {
    echo -e "\e[95m**\e[0m  Installing basic \e[93m${DOTS_DIR}\e[0m"
    yay -S --answerclean None --answerdiff None --needed - < basics.lst

    echo -e " \e[95m->\e[0m Caching fonts"
    fc-cache -v &> /dev/null

    echo -e " \e[95m->\e[0m Installing Oh-My-Fish"
    curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish -c exit
    fish -c "omf install kawasaki"

    echo -e " \e[95m->\e[0m Miscellaneous stuff"
    xdg-user-dirs-update
}

install_hyprland() {
    echo -e "\e[95m**\e[0m  Installing Hyprland Rice \e[93m${DOTS_DIR}\e[0m"
    gsettings set org.cinnamon.desktop.default-applications.terminal exec alacritty
}

install_neovim() {

}

create_symlink() {
   SOURCE_DIR=$1
   TARGET_DIR=$2

    # Check actual files or folder are present
    if [[ (-f "$TARGET_DIR" || -d "$TARGET_DIR") && ! -L "$TARGET_DIR" ]]; then
        mv ${TARGET_DIR} ${TARGET_DIR}_backup
        echo -e "    \e[91m${TARGET_DIR} \e[0m was backuped into \e[91m${TARGET_DIR}_backup\e[0m."
        rm -rf ${TARGET_DIR}
    fi

    if [[ -L "$TARGET_DIR" ]]; then
        if [ ! "$(readlink -- "$TARGET_DIR")" = "$SOURCE_DIR" ]; then
            echo -e "    \e[91m!\e[0m Symlink for \e[93m${SOURCE_DIR}\e[0m exists, but from different target."
            rm ${TARGET_DIR}
        else
            echo -e "    \e[93m${SOURCE_DIR}\e[0m is already linked to \e[93m${TARGET_DIR}\e[0m."
            return
        fi
    fi
    echo -e "    Symlink for \e[92m${SOURCE_DIR}\e[0m to \e[92m${TARGET_DIR}\e[0m was created."
    ln -s $SOURCE_DIR $TARGET_DIR
}

link_configuration() {
    SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    DOTS_DIR=$SCRIPT_DIR/home

    echo -e "\e[95m**\e[0m  Symlinking files from \e[93m${DOTS_DIR}\e[0m"

    # # Link folder in ~/.config
    echo -e " \e[95m->\e[0m Folder within \e[93m/home/$(whoami)/.config\e[0m"
    for folder in $(\ls $DOTS_DIR/.config); do
        SOURCE_DIR=$DOTS_DIR/.config/$folder
        TARGET_DIR=~/.config/$folder

        create_symlink $SOURCE_DIR $TARGET_DIR
    done

    # Link additional dirs
    echo -e " \e[95m->\e[0m Additional files and folders within \e[93m/home/$(whoami)\e[0m"
    ADDITIONAL_DIRS=(
        .bash_profile
        .icons/default/index.theme
        .local/bin
        .local/share/backgrounds
        .local/share/icons/dunst
        .local/share/sounds
    )

    for dir in "${ADDITIONAL_DIRS[@]}"; do
        mkdir -p $dir
        SOURCE_DIR=$DOTS_DIR/$dir
        TARGET_DIR=~/$dir

        create_symlink $SOURCE_DIR $TARGET_DIR
    done
}

apply_themes() {
    echo -e "\e[95m**\e[0m  Install theme, icons and cursor"

    # Cursor
    echo -e " \e[95m->\e[0m Installing dependencies"
    sudo pacman -S make inkscape xorg-xcursorgen --needed

    git clone https://github.com/varlesh/volantes-cursors.git
    cd volantes-cursors
    echo -e " \e[95m->\e[0m Building ..."
    make build &> /dev/null
    sudo make install
    cd $SCRIPT_DIR
    rm -rf volantes-cursors

    # Theme and icons
    git clone https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme
    sudo cp -r Tokyo-Night-GTK-Theme/icons/Tokyonight-Moon /usr/share/icons
    sudo cp -r Tokyo-Night-GTK-Theme/themes/Tokyonight-Dark-BL-LB /usr/share/themes
    sudo cp -r Tokyo-Night-GTK-Theme/themes/Tokyonight-Dark-BL-LB/gtk-4.0 ~/.config
    rm -rf Tokyo-Night-GTK-Theme
}

installation
# link_configuration
# apply_themes

exit 0