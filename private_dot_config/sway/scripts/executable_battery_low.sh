#!/bin/sh
while true; do
  battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`
  if [ $battery_level -le 10 ]; then
    notify-send "battery low" "(${battery_level}%)"
  fi
  if [ $battery_level -le 5 ]; then
    notify-send "batty very low" "(${battery_level}%!)"
  fi
  sleep 60
done
