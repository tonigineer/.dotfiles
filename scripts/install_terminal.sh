#!/usr/bin/env bash

yay -S alacritty neovim-git vim zsh \
	curl eza unzip tar wget zip \
	btop-git cava-git cmatrix-git neofetch tty-clock-git \
	ttf-jetbrains-mono-nerd ttf-cascadia-code-nerd

# Link all configs
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_DIR/utils.sh"

create_symlink .bashrc
create_symlink .bash_profile
create_symlink .bash_aliases

create_symlink .local/bin

create_symlink .config/alacritty
create_symlink .config/btop
create_symlink .config/cava
create_symlink .config/neofetch
create_symlink .config/nvim

create_symlink .config/zsh
ln -s ~/.config/zsh/.zshrc ~/.zshrc

# Install dependencies for nvim config
sudo pacman -S fd luarocks npm python-pip python-pynvim ripgrep rustup yarn wl-clipboard
rustup default stable

yay -S fswatch

yarn global add tree-sitter-cli
cargo install tree-sitter-cli
sudo npm install -g tree-sitter-cli
