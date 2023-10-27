#!/usr/bin/env bash

dunstify -u critical -t 0 -a Computer -i icons8-knowledge-64 "¡Hola! $(whoami)" "$(~/.local/bin/retrieve-random-quote.sh)"
paplay ~/.local/share/sounds/discovery.ogg