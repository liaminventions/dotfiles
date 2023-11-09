#!/bin/bash
CACHE_DIR="$HOME/.cache/voice"
mkdir $CACHE_DIR
function begin() {
  rm "$CACHE_DIR/voice.lock"
  nerd-dictation begin --simulate-input-tool WTYPE 
}
function end() {
  touch "$CACHE_DIR/voice.lock"
  nerd-dictation end
}
[ -f "$CACHE_DIR/voice.lock" ] && begin || end

