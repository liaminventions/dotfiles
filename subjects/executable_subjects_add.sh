#!/bin/sh

# Script to dynamically add a subject to the subjects script
TARGET="$HOME/.config/eww/iceberg/menu/scripts/subjects"

if [ "$#" -lt 1 ]; then
  echo "Usage $0 <subjectname>"
  exit 1
fi

SUBJECT=$1

cp "$TARGET" "${TARGET}.bak"

# Remove any old entries for the same subject
sed -i "/function toggle-${SUBJECT}/,+15 d" "$TARGET"
sed -i "/$SUBJECT/,+1 d" "$TARGET"

BLOCK1=$(cat <<EOF
function toggle-${SUBJECT} {
  [ -f "\$CACHE_DIR/${SUBJECT}.lock" ] && rm "\$CACHE_DIR/${SUBJECT}.lock" || touch "\$CACHE_DIR/${SUBJECT}.lock"
  [ -f "\$CACHE_DIR/${SUBJECT}.lock" ] && killall discipline || "$HOME/.config/hypr/scripts/discipline" 
}

function follow_${SUBJECT} {
  [ -f "\$CACHE_DIR/${SUBJECT}.lock" ] && local status="off" || local status="on"
  echo "{\\\"state\\\":\\\"\$status\\\"}"
	while sleep 0.1; do
		[ -f "\$CACHE_DIR/${SUBJECT}.lock" ] && local ns="off" || local ns="on"
		if [ \$status != \$ns ];then
			status=\$ns
			echo "{\\\"state\\\":\\\"\$status\\\"}"
		fi
	done
}
EOF
)

BLOCK2=$(cat <<EOF
  "toggle-${SUBJECT}") toggle-${SUBJECT};;
  "act-${SUBJECT}") follow_${SUBJECT};;
EOF
)

awk -v block="$BLOCK1" '
  /case "\$1" in/ {
    print block
  }
  { print }
' "$TARGET" > "${TARGET}.tmp"

awk -v block="$BLOCK2" '
  /*) echo "unknown command";;/ {
    print block
  }
  { print }
' "${TARGET}.tmp" > "${TARGET}2.tmp"

mv "${TARGET}2.tmp" "$TARGET"

rm "${TARGET}.tmp">/dev/null 2>&1

chmod +x "${TARGET}"

echo "Added $SUBJECT to $TARGET."
