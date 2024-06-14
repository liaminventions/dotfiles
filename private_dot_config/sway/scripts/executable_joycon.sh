#!/bin/bash
set -ex

CACHE_DIR="$HOME/.cache/joycon"
#mkdir $CACHE_DIR

function enable () { 
  touch "$CACHE_DIR/joycon.lock"
  joycond-cemuhook & disown
}

function disable () { 
  rm "$CACHE_DIR/joycon.lock"
  killall joycond-cemuhook
}

[ -f "$CACHE_DIR/joycon.lock" ] && disable || enable
