#!/usr/bin/env bash
handle() {
    output=$(playerctl metadata --format '{{ title }}' | awk '{if(length($0) > 45) print substr($0, 1, 42) "..."; else print $0}')
    grep "No players found" <<< $ouput && {
        output=''
    }
    echo $output
}

handle
playerctl --follow metadata --format '{{ title }}' | while read -r _; do
    handle
done
