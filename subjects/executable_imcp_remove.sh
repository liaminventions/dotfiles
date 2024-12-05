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

echo "Removed $SUBJECT from imcp and imcp-full."
