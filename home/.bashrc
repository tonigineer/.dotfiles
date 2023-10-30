#!/usr/bin/env bash

# ------ SOURCING ------
[[ -f ~/.cargo/env ]] && . ~/.cargo/env
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

[[ -d "$HOME/.local/bin" ]] && PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/.cargo/bin" ]] && PATH="$HOME/.cargo/bin:$PATH"


# ------ PROMPT ------
export PROMPT_DIRTRIM=3

function custom_prompt {
    BRANCH=$(git status 2>/dev/null | grep "On branch " | rev | cut -d " " -f1 | rev)

    local retval=$?
    local field1="$(tput setaf 255)$(tput sgr0)"
    local field2="$(tput setaf 4)\u$(tput sgr0)$(tput setaf 8):$(tput sgr0)$(tput setaf 3)\h$(tput sgr0)"
    local field3="$(tput setaf 255)\w$(tput sgr0)"
    local field5='❯ '

    local prpt_git=$([[ ! "$BRANCH" = "" ]] && echo "$(tput setaf 8)⌜$(tput sgr0)$(tput setaf 1) $(tput sgr0)${BRANCH}$(tput setaf 8)⌟$(tput sgr0)" || echo "")

    PS1=$"${field1} ${field2} ${field3} ${prpt_git}"$'\n'"${field5}"
}

PROMPT_COMMAND="custom_prompt; ${PROMPT_COMMAND}"

