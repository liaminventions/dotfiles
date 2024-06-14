#!/bin/sh
killall pipewire; killall pipewire-pulse; killall wireplumber
sleep 1;
/usr/bin/pipewire &
/usr/bin/pipewire-pulse &
/usr/bin/wireplumber
