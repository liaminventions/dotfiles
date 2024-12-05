#!/bin/sh

IMCP="$HOME/.config/hypr/scripts/imcp"
IMCPF="$HOME/.config/hypr/scripts/imcp-full"

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <subject>"
  exit 1
fi

SUBJECT="$1"

cp "$IMCP" "${IMCP}.bak"
cp "$IMCPF" "${IMCPF}.bak"

sed -i "/${SUBJECT}.lock/,+1 d" "$IMCP"
sed -i "/${SUBJECT}.lock/,+1 d" "$IMCPF"
sed -i "4s/elif/if/" $IMCP
sed -i "4s/elif/if/" $IMCPF

BLOCK="elif [ ! -f ~/.cache/eww/${SUBJECT}.lock ]; then
  FILE=\$HOME/Pictures/Screenshots/${SUBJECT}/\${date}.png"

awk -v block="$BLOCK" '
  /else/ {
    print block
  }
  { print }
' "$IMCP">"${IMCP}.tmp"

awk -v block="$BLOCK" '
  /else/ {
    print block
  }
  { print }
' "$IMCPF">"${IMCPF}.tmp"

mv "${IMCP}.tmp" "$IMCP"
mv "${IMCPF}.tmp" "$IMCPF"

chmod +x $IMCP $IMCPF

mkdir ~/Pictures/Screenshots/${SUBJECT}

echo "Added $SUBJECT to imcp and imcp-full."
