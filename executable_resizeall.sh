#!/bin/bash

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <resolution> <file1> <file2> ..."
  exit 1
fi

res="$1"; shift

for file in "$@"; do
  if [ -f "$file" ]; then
    ~/resize.sh "$file" "$res"
  else
    echo "'$file' does not exist; skipping..."
  fi
done
