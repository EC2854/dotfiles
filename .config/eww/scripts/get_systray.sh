#!/usr/bin/env bash

count=0

dbus-monitor --session "interface='org.kde.StatusNotifierWatcher'" |
while read -r signal; do
    if [[ $signal == *"StatusNotifierItemRegistered"* ]]; then
      count=$(($count + 1))
    elif [[ $signal == *"StatusNotifierItemUnregistered"* ]] then
      count=$(($count - 1))
    fi

    echo "$count"
done
