#!/bin/sh

# Script to dynamically add a subject to the subjects script
TARGET="$HOME/.config/eww/iceberg/menu/sys-menu/sys-menu.yuck"

if [ "$#" -lt 1 ]; then
  echo "Usage $0 <subjectname><icon>"
  exit 1
fi

SUBJECT="$1"
ICON="$2"

cp "$TARGET" "${TARGET}.bak"

LINE1="(deflisten act-${SUBJECT} \"scripts/subjects act-${SUBJECT}\")"
LINE2="    (button :class \"act-${SUBJECT} act$\{act-${SUBJECT}.state\}\" :onclick \"./scripts/subjects toggle-${SUBJECT}\" :tooltip \"${SUBJECT}\" \" ${ICON} \")"

sed -i "/${SUBJECT}/d" $TARGET

awk -v line="$LINE1" '
  /\(defwidget\ media\[\]/ {
    print line
  }
  { print }
' "$TARGET">"${TARGET}.tmp"

awk -v line="$LINE2" '
  /\)\)\(defwindow sys-menu0/ {
    print line
  }
  { print }
' "${TARGET}.tmp">"${TARGET}2.tmp"

mv "${TARGET}2.tmp" "$TARGET"

rm "${TARGET}.tmp">/dev/null 2>&1
echo "Added $SUBJECT to $TARGET."
