#!/usr/bin/env bash

# Install optionals
sudo pacman -S \
    cargo \
    fd \
    npm \
    python-neovim \
    ripgrep

sudo npm install -g neovim yarn tree-sitter

cargo install tree-sitter-cli