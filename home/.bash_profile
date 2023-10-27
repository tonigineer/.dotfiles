#!/usr/bin/env bash

[[ -d "$HOME/.local/bin" ]] && PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/.cargo/bin" ]] && PATH="$HOME/.cargo/bin:$PATH"

[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases
[[ -f ~/.cargo/env ]] && . ~/.cargo/env

# [[ $(tty) == '/dev/tty1' && ! $DISPLAY ]] && exec bash ~/.local/bin/hyprland
