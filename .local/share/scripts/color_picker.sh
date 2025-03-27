#!/bin/sh

grim -g "$(slurp -p -b 0d0d14c0 -c ac3231)" -t ppm - | magick - -format '%[pixel:p{0,0}]' txt:- | tail -n 1 | cut -d ' ' -f 4 | wl-copy 
