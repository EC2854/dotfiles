#!/usr/bin/env bash

chosen=$(printf "  Power Off\n  Restart\n  Suspend\n  Lock" | fuzzel -d)

case "$chosen" in
    "  Power Off") systemctl poweroff;;
    "  Restart") systemctl reboot;;
    "  Suspend") systemctl suspend;;
    "  Lock") ~/.local/share/scripts/hyprlock.sh;;
    *) exit 1 ;;
esac
