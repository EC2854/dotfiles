#!/usr/bin/dash

if [ $1 == "up" ]; then
    playerctl next
else
    playerctl previous
fi
