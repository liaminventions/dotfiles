#!/bin/bash
CACHE_DIR="$HOME/.cache/voice"

mkdir CACHE_DIR
[ -f "$CACHE_DIR/voice.lock" ] && nerd-dictation begin --simulate-input-tool WTYPE || nerd-dictation end
