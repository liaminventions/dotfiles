#!/bin/bash

# Script to dynamically add subjects to the discipline script
TARGET_SCRIPT="$HOME/.config/hypr/scripts/discipline"

# Ensure required arguments are provided
if [ "$#" -lt 3 ]; then
    echo "Usage: $0 <subject> <whitelist_items_comma_separated> <class_whitelist_items_comma_separated>"
    exit 1
fi

SUBJECT=$1
WHITELIST=$(echo "$2" | tr ',' ' ')
CLASS_WHITELIST=$(echo "$3" | tr ',' ' ')

# Backup the target script
cp "$TARGET_SCRIPT" "${TARGET_SCRIPT}.bak"

new_comparison="[ -f \"\$CACHE_DIR/$SUBJECT.lock\" ] &&"
ESCAPED_COMP="\ \ \ \ $(printf "%s\n" "$new_comparison" | sed 's/\$/\\$/g')"

# Escape $ characters in strings for safe handling
ESCAPED_WHITELIST=$(printf "%s\n" "$WHITELIST" | sed 's/\$/\\$/g')
ESCAPED_CLASS_WHITELIST=$(printf "%s\n" "$CLASS_WHITELIST" | sed 's/\$/\\$/g')

# Remove any old entries for the same subject
sed -i "/${SUBJECT}.lock\" ] &&/d" "$TARGET_SCRIPT"
sed -i "/$SUBJECT whitelist/,+27 d" "$TARGET_SCRIPT"

sed -i "/true/i $ESCAPED_COMP" "$TARGET_SCRIPT"

# Generate the new subject block with proper variable interpolation
NEW_SUBJECT_BLOCK=$(cat <<EOF
    # $SUBJECT whitelist
    ${SUBJECT}_whitelist="$ESCAPED_WHITELIST"
    ${SUBJECT}_class_whitelist="$ESCAPED_CLASS_WHITELIST"

    if [ ! -f "\$CACHE_DIR/${SUBJECT}.lock" ]; then
      if [ "\$window" != "" ]; then
        for word in \${${SUBJECT}_whitelist}; do
          if [[ "\$window" == *"\$word"* ]]; then
            hits=1
            break
          else
            hits=0
          fi
        done
        if [ \$hits != 1 ]; then
          for word2 in \${${SUBJECT}_class_whitelist}; do
            if [[ "\$windowclass" == *"\$word2"* ]]; then
              hits=1
              break
            else
              hits=0
            fi
          done
        fi
      else
        hits=1
      fi
    fi
EOF
)

# Insert the new subject block before the target line
awk -v block="$NEW_SUBJECT_BLOCK" '
  /if \[ \$hits == 0 \] && \[ \$prevhit == 0 \]; then/ {
    print block
  }
  { print }
' "$TARGET_SCRIPT" > "${TARGET_SCRIPT}.tmp"

# Replace the original script with the modified version
mv "${TARGET_SCRIPT}.tmp" "$TARGET_SCRIPT"

chmod +x "${TARGET_SCRIPT}"

echo "Added $SUBJECT to $TARGET_SCRIPT."
