#!/bin/bash
[ $(cat /sys/class/power_supply/BAT0/capacity) -lt 15 ] && [ "$(cat /sys/class/power_supply/BAT0/status)" = "Discharging" ] && export DISPLAY=:0.0 && notify-send -u critical "BATTERY LOW
$(cat /sys/class/power_supply/BAT0/capacity)% REMAINING"
sleep 20
pkill mako
