#!/bin/bash

# Target workspace number (pass as the first argument)
TARGET_WS="$1"

if [[ -z "$TARGET_WS" ]]; then
    echo "Usage: $0 <target-workspace-number>"
    exit 1
fi

# Get current workspace ID
CURRENT_WS=$(hyprctl activeworkspace -j | jq '.id')

if [[ "$CURRENT_WS" == "$TARGET_WS" ]]; then
    echo "Target workspace is the same as current. No action taken."
    exit 0
fi

# Get list of windows on current workspace
WINDOWS=$(hyprctl clients -j | jq -r --argjson ws "$CURRENT_WS" '.[] | select(.workspace.id == $ws) | .address')

for WIN in $WINDOWS; do
    hyprctl dispatch movetoworkspace "$TARGET_WS,address:$WIN"
done

echo "Moved all windows from workspace $CURRENT_WS to workspace $TARGET_WS."
