#!/usr/bin/env bash
area=$(slurp -b 0d0d14c0 -c ac3231)
grim -g "$area" - | wl-copy --type image/png
