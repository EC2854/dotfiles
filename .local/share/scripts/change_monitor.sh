#!/bin/sh

profile=$(grep "profile" ~/.config/kanshi/config | awk '{print $2}' | grep -v "default" | tofi) &&
kanshictl switch $profile &&
eww reload  
