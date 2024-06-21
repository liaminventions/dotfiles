#!/bin/sh
while true; do
  acpi -b | grep "Charging"
  ret=$?
  if [ $ret -ne 0 ]; then
    battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`
    if [ $battery_level -le 10 ]; then
      notify-send "battery low" "(${battery_level}%)"
    elif [ $battery_level -le 5 ]; then
      notify-send "batty very low" "(${battery_level}%!)"
    fi
  fi
  sleep 60
done
