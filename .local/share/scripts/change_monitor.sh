#!/bin/sh

profile=$(grep "profile" ~/.config/kanshi/config | awk '{print $2}' | grep -v "default" | fuzzel -d) &&
kanshictl switch $profile &&
systemctl --user restart eww
