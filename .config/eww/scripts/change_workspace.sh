#!/usr/bin/env bash
direction=$1
current=$2
if [[ $direction == "down" ]]; then
    target=$((current+1))
    if [[ $target == 11 ]]; then
        exit 0
    fi
    niri msg action focus-workspace $target
elif [[ $direction == "up" ]]; then
    target=$((current-1))
    niri msg action focus-workspace $target
fi
