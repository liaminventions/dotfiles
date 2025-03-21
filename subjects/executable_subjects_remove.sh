#!/bin/sh

# Script to dynamically remove a subject from the subjects script
TARGET="$HOME/.config/eww/iceberg/menu/scripts/subjects"

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <subject>"
  exit 1
fi

SUBJECT=$1

cp "$TARGET" "${TARGET}.bak"

# Remove any old entries for the same subject
sed -i "/function toggle-${SUBJECT}/,+15 d" "$TARGET"
sed -i "/$SUBJECT/,+1 d" "$TARGET"

echo "Removed $SUBJECT from $TARGET"
