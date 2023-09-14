#!/bin/bash
set -ex
# this is a script to hibernate the computer at wake up in the morning + play a song using timidity


DATE="2023-07-02" 
TIME="12:00"

sleep 1
sudo rtcwake -m disk --date "$DATE $TIME" 
timidity ~/Downloads/BotB\ 60729\ SquareWave\ -\ Hallo.mid &
~/.config/hypr/scripts/lock_stat
killall timidity
