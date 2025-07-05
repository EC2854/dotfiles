#!/usr/bin/env bash
area=$(XCURSOR_THEME="Capitaine Cursors" slurp -b 171216c0 -c eeb4ea)
grim -g "$area" - | wl-copy
