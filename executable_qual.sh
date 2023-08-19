#!/bin/bash
set -e
set -x
set -o pipefail

IN=$(rofi -modi file-browser-extended -show file-browser-extended -file-browser-stdout)

echo "$IN"
echo "whar video qual? (recomend: 220000 or so):"
read VIDEO
echo "whar adio qual? (hmm low lik 50000 ig):"
read AUDIO

echo "otput fil?"
read OUT

ffmpeg -i $IN -b:v $VIDEO -b:a $AUDIO $OUT
exit 
