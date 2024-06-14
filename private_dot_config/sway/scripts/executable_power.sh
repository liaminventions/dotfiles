#!/bin/sh

case "$1" in
  "hibernate")
    echo shutdown | tee /sys/power/disk
    echo disk | tee /sys/power/state
    exit 0
    ;;
  "suspend")
    echo "mem" | tee /sys/power/state
    exit 0
    ;;
  "shutdown")
    shutdown
    exit 0
    ;;
  "reboot")
    reboot
    exit 0
    ;;
esac
