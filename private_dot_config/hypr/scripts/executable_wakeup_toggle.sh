#!/bin/bash
set -ex

CACHE_DIR="$HOME/.cache/power"

function enable () { touch "$CACHE_DIR/alarm.lock"; }

function disable () { rm "$CACHE_DIR/alarm.lock"; }

[ -f "$CACHE_DIR/alarm.lock" ] && disable || enable
