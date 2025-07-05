#!/usr/bin/dash

playerctl status --follow | \
while read -r status; do
    if [ "$status" = "Playing" ]; then 
        echo "󰏤"
    elif [ "$status" = "Paused" ]; then 
        echo "󰐊"
    else
        echo ""
    fi
done
