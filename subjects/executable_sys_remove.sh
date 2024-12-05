#!/bin/sh

# Script to dynamically add a subject to the subjects script
TARGET="$HOME/.config/eww/iceberg/menu/sys-menu/sys-menu.yuck"

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <subject>"
  exit 1
fi

SUBJECT="$1"

cp "$TARGET" "${TARGET}.bak"

sed -i "/${SUBJECT}/d" $TARGET

echo "Removed $SUBJECT from $TARGET."
