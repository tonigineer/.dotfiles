#!/usr/bin/env bash

CONFIG_DIR=~/.config/nvim
CONFIG_DIR_BACKUP=${CONFIG_DIR}_backup_$(date -I)
CACHE_DIR=~/.dotfiles_cache


# Install configuration
if [ -d $CONFIG_DIR ]; then
    mv ${CONFIG_DIR} ${CONFIG_DIR_BACKUP}
    echo ">> Current neovim config was moved to ${CONFIG_DIR_BACKUP}"
fi

git clone https://github.com/tonigineer/.dotfiles.git ${CACHE_DIR}
mv ${CACHE_DIR}/home/.config/nvim ${CONFIG_DIR}
rm -rf ${CACHE_DIR}


# Install dependencies
sudo yes | pacman -S \
    cargo \
    fd \
    npm \
    python-neovim \
    ripgrep

sudo npm install -g neovim yarn tree-sitter

cargo install tree-sitter-cli