#!/bin/sh
res=$1
shift
for file in "$@"
do
  ~/resize.sh "$file" $res
done

