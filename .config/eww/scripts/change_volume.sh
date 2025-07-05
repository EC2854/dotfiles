#!/usr/bin/dash

if [ "$1" = "up"]]; then
    wpctl set-volume @DEFAULT_"$2"@ 0.05+
elif [ "$1" = "down" ]; then
    wpctl set-volume @DEFAULT_"$2"@ 0.05-
else 
    wpctl set-volume @DEFAULT_"$2"@ "$(echo $1 | awk '{print ($1 / 100)}' )"
fi
