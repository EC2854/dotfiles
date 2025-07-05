#!/usr/bin/dash

get_power() {
     echo "$1" | awk '{print int($2*100)}'
}
is_muted() {
    case "$1" in
        *"MUTED"*) return 0;;
        *) return 1;;
    esac
    
}
get_volume_icon() {
    local volume_power=$1
    if [ "$volume_power" -le 0 ] || is_muted "$volume"; then
        eww update volume_muted=true
        echo "󰝟"
    elif [ "$volume_power" -le 30 ]; then
        eww update volume_muted=false
        echo ""
    elif [ "$volume_power" -le 60 ]; then
        eww update volume_muted=false
        echo "󰖀"
    else
        eww update volume_muted=false
        echo "󰕾"
    fi
}
get_mic_icon() {
    if is_muted "$mic"; then
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

    volume_power=$(get_power "$volume")
    mic_power=$(get_power "$mic")

    volume_icon=$(get_volume_icon "$volume_power")
    mic_icon=$(get_mic_icon)

    echo "{ \"volume_icon\": \"$volume_icon\", \"volume_value\": \"$volume_power\", \"mic_icon\" : \"$mic_icon\", \"mic_value\" : \"$mic_power\" }"
}

handle
pactl subscribe | grep --line-buffered "sink\|source" | while read -r _; do
    handle
done


