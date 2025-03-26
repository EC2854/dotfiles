#!/usr/bin/env bash


get_volume() {
    awk '{print int($2*100)}' <<< "$volume"
}

is_volume_muted() {
    grep MUTED <<< "$volume" > /dev/null 
}

get_mic() {
    awk '{print int($2*100)}' <<< "$mic"
}

is_mic_muted() {
    grep MUTED <<< "$mic" > /dev/null 
}


get_volume_icon() {
    local volume_power=$1
    if [ "$volume_power" -le 0 ] || eval is_volume_muted; then
        eww update volume_muted=true
        echo "󰝟"
    elif [ "$volume_power" -le 30 ]; then
        eww update volume_muted=false
        echo "󰕿"
    elif [ "$volume_power" -le 60 ]; then
        eww update volume_muted=false
        echo "󰖀"
    else
        eww update volume_muted=false
        echo "󰕾"
    fi
}

function get_mic_icon() {
    if eval is_mic_muted; then
        eww update mic_muted=true
        echo "󰍭"
    else
        eww update mic_muted=false
        echo "󰍬"
    fi
}

handle() {
    volume=$(wpctl get-volume @DEFAULT_SINK@)
    mic=$(wpctl get-volume @DEFAULT_SOURCE@)
    volume_power=$(get_volume)
    volume_icon=$(get_volume_icon "$volume_power")
    mic_icon=$(get_mic_icon)
    mic_power=$(get_mic)
    echo "{ \"volume_icon\": \"$volume_icon\", \"volume_value\": \"$volume_power\", \"mic_icon\" : \"$mic_icon\", \"mic_value\" : \"$mic_power\" }"
}

handle
pactl subscribe | while read -r _; do
    handle
done


