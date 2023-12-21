#!/usr/bin/env bash

# References: https://github.com/lukePeavey/quotable

# Sometimes it does not retrieve a quote at the first try,
# therefore try again
for _ in {1..10}; do
	quote=$(wget https://api.quotable.io/random -q -O - | grep -oP '(?<=content":").*(?=","author)')
	[[ -n "$quote" ]] && break
done
[[ -z "$quote" ]] && quote="Could not retrieve quote."

# Output quote and make sound
dunstify \
	-u critical \
	-t 60000 \
	-a Computer \
	-i icons8-knowledge-64 \
	"¡Hola! $(whoami)" \
	"${quote}"
paplay ~/.local/share/sounds/discovery.ogg
