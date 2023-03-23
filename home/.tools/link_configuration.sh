#!/usr/bin/env bash

for folder in .config/* ; do
    CURRENT_DIR=$PWD/$folder
    HOME_DIR=~/$folder

    # echo "$CURRENT_DIR"
    # echo "$HOME_DIR"

    if [[ -d "$HOME_DIR" ]]; then
        if [[ -L "$HOME_DIR" ]]; then
            echo -e "\e[92m${CURRENT_DIR}\e[0m is already linked to \e[92m${HOME_DIR}\e[0m."
            continue
        else
            mv ${HOME_DIR} ${HOME_DIR}_backup
            echo -e "\e[91m${HOME_DIR}\e[0m was backuped into \e[91m${HOME_DIR}_backup\e[0m."
            rm -rf ${HOME_DIR}
        fi
    fi
    ln -s $CURRENT_DIR $HOME_DIR
    echo -e "Simlink for \e[93m${CURRENT_DIR}\e[0m to \e[93m${HOME_DIR}\e[0m was created."

done
