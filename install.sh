#!/usr/bin/env bash

if [ ! -d ~/.config ]; then
    echo -e "\e[91mDirectory ~/.config does not exist, but was created.\e[0m"
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
    git clone https://github.com/oh-my-fish/oh-my-fish
    oh-my-fish/bin/install --offline
    rm -rf oh-my-fish
    fish -c "omf install kawasaki"

    echo -e " \e[95m->\e[0m Miscellaneous stuff"
    xdg-user-dirs-update
}

install_hyprland() {
    echo -e "\e[95m**\e[0m  Installing Hyprland Rice\e[93m${DOTS_DIR}\e[0m"
    yay -S --answerclean None --answerdiff None --needed - < rice.lst
}

install_neovim() {
    echo -e "\e[95m**\e[0m  Installing Neovim\e[93m${DOTS_DIR}\e[0m"
}

install_tools() {
    echo -e "\e[95m**\e[0m  Installing Tools\e[93m${DOTS_DIR}\e[0m"
    # spotify  # must be build from source
    # spotify-blur-me-not
}

install_fancy() {
    echo -e "\e[95m**\e[0m  Youtube via MPV\e[93m${DOTS_DIR}\e[0m"
    yay -S yt-dlp mpv
    # NOTES:    https://github.com/mps-youtube/yewtube/issues/1143#issue-792680370
                https://www.linuxfordevices.com/tutorials/linux/watch-youtube-videos-on-mpv-player
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

    mkdir -p ~/.icons/default/ ~/.local/share/backgrounds ~/.local/share/icons/

    for dir in "${ADDITIONAL_DIRS[@]}"; do
        SOURCE_DIR=$DOTS_DIR/$dir
        TARGET_DIR=~/$dir

        create_symlink $SOURCE_DIR $TARGET_DIR
    done

    echo -e " \e[95m->\e[0m Adding ~/.local/bin to PATH\e[93m/home/$(whoami)\e[0m"
    export PATH=$PATH:~/.local/bin
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

    if [ ! -d ~/.local/share/backgrounds/.loop ]; then
        echo -e "\e[95m**\e[0m  Setting first wallpaper for background loop"
        mkdir -p ~/.local/share/backgrounds/.loop
        cp -r ~/.local/share/backgrounds/animated/cyberpunk-night.gif ~/.local/share/backgrounds/.loop
    fi
}

install_basics
install_hyprland
install_tools
install_neovim
link_configuration
apply_themes
