#!/bin/bash

# Script to dynamically add subjects to the discipline script
TARGET_SCRIPT="$HOME/.config/hypr/scripts/discipline"

# Ensure required arguments are provided
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <subject>" 
    exit 1
fi

SUBJECT=$1

# Backup the target script
cp "$TARGET_SCRIPT" "${TARGET_SCRIPT}.bak"

# Remove any old entries for the same subject
sed -i "/${SUBJECT}.lock\" ] &&/d" "$TARGET_SCRIPT"
sed -i "/$SUBJECT whitelist/,+27 d" "$TARGET_SCRIPT"

echo "Removed $SUBJECT from $TARGET_SCRIPT."
