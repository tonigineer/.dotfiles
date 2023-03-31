#!/usr/bin/env bash

# https://github.com/lukePeavey/quotable

echo "$(wget https://api.quotable.io/random -q -O - | grep -oP '(?<=content":").*(?=","author)')"
