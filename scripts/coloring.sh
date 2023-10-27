#!/usr/bin/env bash

function color ()
{
    # https://dev.to/ifenna__/adding-colors-to-bash-scripts-48g4

    ENDCOLOR="\e[0m"

    case "${2,,}" in  # lowercase
        # a*             ) foo;;    # matches anything starting with "a"
        # b?             ) bar;;    # matches any two-character string starting with "b"
        # c[de]          ) baz;;    # matches "cd" or "ce"
        # me?(e)t        ) qux;;    # matches "met" or "meet"
        # @(a|e|i|o|u)   ) fuzz;;   # matches one vowel
        # m+(iss)?(ippi) ) fizz;;   # matches "miss" or "mississippi" or others
        # *              ) bazinga;; # catchall, matches anything not matched above
        black   ) COLOR="\e[30m";;
        red     ) COLOR="\e[31m";;
        green   ) COLOR="\e[32m";;
        yellow  ) COLOR="\e[33m";;
        blue    ) COLOR="\e[34m";;
        magenta ) COLOR="\e[35m";;
        cyan    ) COLOR="\e[36m";;
        white   ) COLOR="\e[37m";;
        *       ) COLOR="\e[97m";;
    esac

    echo -n -e "${COLOR}$1${ENDCOLOR}"
}
