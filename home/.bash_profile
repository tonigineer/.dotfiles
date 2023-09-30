#!/usr/bin/env bash

[[ -d "$HOME/.local/bin" ]] && PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/.cargo/bin" ]] && PATH="$HOME/.cargo/bin:$PATH"

[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -f ~/.cargo/env ]] && . ~/.cargo/env
[[ -f ~/.config/zsh/alias.zsh ]] && . ~/.config/zsh/alias.zsh

[[ $(tty) == '/dev/tty1' && ! $DISPLAY ]] && exec bash ~/.local/bin/hyprland
