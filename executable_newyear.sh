#!/bin/bash
set -ex
# new year drop sync script

# ___CONSTANTS___::

# music/video file:

#FILE="/home/waverider/Videos/copy_0DAE90C5-6934-4D36-8731-3956A4F830DD.mp4"
FILE="/home/waverider/Videos/NEWYEARS.mp4"

RESUMETIME="8" # seconds it takes to resume (use a stopwatch)
PREDROPTIME="55" # seconds before drop

# start at 23:59:60
HOURS="23"
MINUTES="59"
SECONDS="60"

#HOURS="23"
#MINUTES="31"
#SECONDS="60"

#SECONDS=$((SECONDS + 1))

# ___THE MATH___ ::

# start at 23:59:60
# CALCOFFSET = (take 60 and subtract the result of resume time plus the length of the song's pre-drop.)
# if "CALCOFFSET" is negative, roll back another minute and add (60 - abs(CALCOFFSET)) seconds
# or rather, 60+CALCOFFSET since it's already negative.

# BEGIN!

# CALCOFFSET = (take 60 and subtract the result of resume time plus the length of the song's pre-drop.)

TOTALOFFSET=$((RESUMETIME + PREDROPTIME)) # total offset time from midnight (before)
#CALCOFFSET=$(expr SECONDS - TOTALOFFSET) # from the text above...
# extra math to do a non-integer argument (negative numbers)
CALCOFFSET=$(printf %.0f "$((SECONDS - TOTALOFFSET))")

# if "CALCOFFSET" is negative, roll back another minute and add (60+CALCOFFSET) seconds

if [ $((CALCOFFSET <= 0)) ]       
then 
  ((MINUTES=MINUTES-1))           # roll back another minute
  ((SECONDS=SECONDS+CALCOFFSET))  # and add (60+CALCOFFSET) seconds. SECONDS is 60 here.
else
  ((SECONDS=CALCOFFSET))          # also if it's not negative, set the SECONDS to CALCOFFSET
fi

# now set time to the total timestamp.
TIME="$HOURS:$MINUTES:$SECONDS"


# now DO IT!!!!!

sleep 1
#sudo rtcwake -m disk --date "tomorrow" 

sudo rtcwake -m disk --date "$TIME"
xmp ~/home/butter.xm -i nearest & 
swww init & disown
cavasik & disown
eww -c ~/.config/eww/bg open clock & disown
sleep 45
mpv --fs $FILE
fg
