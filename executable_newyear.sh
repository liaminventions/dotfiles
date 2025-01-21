#!/bin/zsh
set -ex
# new year drop sync script

# ___CONSTANTS___::
DISC_ENCRYPTED=1

# music/video file:

#FILE="/home/waverider/Videos/copy_0DAE90C5-6934-4D36-8731-3956A4F830DD.mp4"
FILE="/home/waverider/Videos/NEWYEARS2025.mp4"

if [[ $DISC_ENCRYPTED == 0 ]]; then
  RESUMETIME="8" # seconds it takes to resume (use a stopwatch)
fi
SONGOFFSET="50"
PREDROPTIME=$SONGOFFSET # seconds before drop

# start at 23:59:60
HOURS="23"
MINUTES="59"
SECONDS="60"

#HOURS="23"
#MINUTES="27"
#SECONDS="60"

#SECONDS=$((SECONDS + 1))

# ___THE MATH___ ::

# start at 23:59:60
# CALCOFFSET = (take 60 and subtract the result of resume time plus the length of the song's pre-drop.)
# if "CALCOFFSET" is negative, roll back another minute and add (60 - abs(CALCOFFSET)) seconds
# or rather, 60+CALCOFFSET since it's already negative.

# BEGIN!

# CALCOFFSET = (take 60 and subtract the result of resume time plus the length of the song's pre-drop.)

# total offset time from midnight (before)
if [[ $DISC_ENCRYPTED == 0 ]]; then
  TOTALOFFSET=$(echo "$RESUMETIME + $PREDROPTIME"|bc) 
elif [[ $DISC_ENCRYPTED == 1 ]]; then
  TOTALOFFSET=$((PREDROPTIME))
fi
#CALCOFFSET=$(expr SECONDS - TOTALOFFSET) # from the text above...
# extra math to do a non-integer argument (negative numbers)
CALCOFFSET=$(echo "$SECONDS - $TOTALOFFSET"|bc)

# if "CALCOFFSET" is negative, roll back another minute and add (60+CALCOFFSET) seconds

if [ $((CALCOFFSET <= 0)) ]       
then 
  ((MINUTES=$(echo "$MINUTES-1"|bc)))           # roll back another minute
  ((SECONDS=$(echo "$SECONDS+$CALCOFFSET"|bc)))  # and add (60+CALCOFFSET) seconds. SECONDS is 60 here.
else
  ((SECONDS=CALCOFFSET))          # also if it's not negative, set the SECONDS to CALCOFFSET
fi

# now set time to the total timestamp.
calc_time="$HOURS:$MINUTES:$SECONDS"
# normalize time (thanks xat zbd!!)
TIME=$(echo "$calc_time" | awk -F: '{printf "%02d:%02d:%02d", $1, $2 + int($3 / 60), $3 % 60}' | xargs -I {} date -d "1970-01-01 {}" +"%H:%M:%S")

# now DO IT!!!!!

sleep 1
#sudo rtcwake -m disk --date "tomorrow" 

if [[ $DISC_ENCRYPTED == 0 ]]; then 
  sudo rtcwake -m disk --date "$TIME"
elif [[ $DISC_ENCRYPTED == 1 ]]; then
  time_diff=$(( $(date -d "$TIME" +%s) - $(date +%s) ))
  sleep $time_diff
fi

#xmp ~/home/butter.xm -i nearest & 
#swww init & disown
#cavasik & disown
#eww -c ~/.config/eww/bg open clock & disown
#sleep 45
#mpv --fs $FILE
#fg
paplay ~/music/ch/meowmeow.wav & disown
sleep $(echo "$SONGOFFSET-10"|bc)
mpv --fs $FILE
fg
