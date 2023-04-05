#!/usr/bin/env bash

# https://github.com/lukePeavey/quotable

# Sometime no quote is retrieved, therefor the while loop.
while [ -z "$quote" ]
do
    quote=$(wget https://api.quotable.io/random -q -O - | grep -oP '(?<=content":").*(?=","author)')
done

echo "$quote"