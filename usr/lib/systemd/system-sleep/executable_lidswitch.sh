#!/bin/sh

PATH=/sbin:/usr/sbin:/bin:/usr/bin

case "$1" in
    pre)
      /usr/bin/rm ~/.cache/power/suspend.lock
    ;;
    post)
      /usr/bin/touch /home/waverider/.cache/power/suspend.lock
    ;;
esac

exit 0
