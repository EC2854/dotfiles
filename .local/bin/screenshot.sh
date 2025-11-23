#!/usr/bin/env bash
area=$(slurp -b 121318c0 -c b2c5ff)
grim -g "$area" - | wl-copy
