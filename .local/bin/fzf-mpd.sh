#!/usr/bin/env bash
export MPD_HOST=/tmp/mpd.sock
FORMAT="%position%. %title% - %artist%"

# shellcheck disable=SC1090 # idc its just styling
. ~/.config/shell/fzf-style.sh

get_songs() {
    # shellcheck disable=SC2086 # $1 can't have quotes to work u dummy :3
    mpc playlist -f "$FORMAT" | fzf ${1:-} | while read -r id _; do
        : "${id/\.}"
        printf "%s\n" "$_"
    done

}
list_folders() {
    mpc lsdirs "$1" | while read -r dir; do
        if [[ -n $(mpc lsdirs "$dir") ]]; then
            list_folders "$dir" &
        else
            printf "%s\n" "$dir"
        fi
    done
}


case "$1" in
    "play") mpc play "$(get_songs)";;
    "del") get_songs -m | while read -r id; do mpc del "$id"; done;;
    "add") list_folders | sort | fzf -m --preview "mpc ls -f \"${FORMAT/\%position\%\. }\" {}" | while read -r folder; do mpc add "$folder"; done;;
    *) printf "[ERR] %s\n" "command not found $1";;
esac
