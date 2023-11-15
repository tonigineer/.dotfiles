#!/usr/bin/env bash

network_info=$(ip -o -4 route show to default)

case $1 in
    --interface)
        interface=$(echo $network_info | awk '{print $5}')
        case $interface in
            wlan*)
                echo "󰀂"
            ;;
            eno*)
                echo "󰈀"
            ;;
            *)
                exit 1
            ;;
        esac
    ;;
    --ip-address)
        echo $network_info | awk '{print $9}'
    ;;
    --gateway)
        echo $network_info | awk '{print $3}'
    ;;
    *)
        exit 1
    ;;
esac