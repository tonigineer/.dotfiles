#!/usr/bin/env bash

# https://github.com/lukePeavey/quotable

# Sometime no quote is retrieved, therefor the while loop.
for try in {1..10} ; do
    quote=$(wget https://api.quotable.io/random -q -O - | grep -oP '(?<=content":").*(?=","author)')
    [[ ! -z "$quote" ]] && break
done

[[ -z "$quote" ]] && quote="Could not retrieve quote."
echo "$quote"