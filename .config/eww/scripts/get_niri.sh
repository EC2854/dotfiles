#!/usr/bin/dash

handle() {
    case "$1" in
        "Workspace focused"*) 
            workspace=$(niri msg -j workspaces | jq '.[] | select(.is_active) | .idx')
            ;;
        "Overview toggled:"*) 
            overview=$(echo "$line" | awk '{print $3}')
            ;;
    esac

    echo "{ \"workspace\": \"$workspace\", \"overview\": \"$overview\" }"
}
# init
workspace=$(niri msg -j workspaces | jq '.[] | select(.is_active) | .id')
overview=$(echo "$line" | awk '{print $3}')
echo "{ \"workspace\": \"$workspace\", \"overview\": \"$overview\" }"

niri msg event-stream | while read -r line; do
    handle "$line"
done
