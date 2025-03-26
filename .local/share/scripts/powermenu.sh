#!/usr/bin/env bash

chosen=$(printf "  Power Off\n  Restart\n  Suspend\n  Lock" | tofi)

case "$chosen" in
    "  Power Off") systemctl poweroff;;
    "  Restart") systemctl reboot;;
    "  Suspend") systemctl suspend;;
    "  Lock") hyprlock;;
    *) exit 1 ;;
esac
