#!/usr/bin/env bash

function get_workspaces_info() {
    swaymsg -t get_workspaces -p | grep "(focused)" | awk '{print $2}'
}

get_workspaces_info

swaymsg -t subscribe '["workspace"]' --monitor | {
    while read -r event; do
        get_workspaces_info
    done
}
