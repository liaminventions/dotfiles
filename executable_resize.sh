#!/bin/bash

# usage: ./resize_video.sh input.mp4 output.mp4 target_size_mb

in="$1"
out="$1"_compressed.mp4
mb="$2"

duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$in")

bitrate=$(echo "(($mb*1024*1024*8)/$duration)/1000"|bc)"k"

ffmpeg -i $in -b:v $bitrate -fflags +genpts -r 60 -y $out
