#!/usr/bin/dash

playerctl metadata --follow --format '{{ title }}|{{ artist }}|{{ mpris:artUrl }}|{{ position }}|{{ mpris:length }}' | \
while IFS='|' read -r title artist cover position duration; do
    jq -cn --arg title "$title" \
           --arg artist "$artist" \
           --arg cover "$cover" \
           --arg position "$position" \
           --arg duration "$duration" \
    '{
        title: ($title | if . == "" then "" else . end),
        artist: ($artist | if . == "" then "" else . end),
        cover: ($cover | if . == "" then "" else sub("^file://"; "") end),
        position: ($position | if . == "" then "" else . end),
        duration: ($duration | if . == "" then "" else . end)
    }'
done

