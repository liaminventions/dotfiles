#!/bin/sh
set -ex

CS="$HOME/.config/hypr/scripts/cachesetup"

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <subject>"
  exit 1
fi

SUBJECT="$1"

cp "$CS" "${CS}.bak"

sed -i "/touch ~\/.cache\/eww\/${SUBJECT}.lock/d" "$CS"

echo "touch ~/.cache/eww/${SUBJECT}.lock">>${CS}

echo "Added $SUBJECT to $CS"
