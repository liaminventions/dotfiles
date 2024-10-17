#!/bin/bash
#set -ex
#plymouth deactivate
#sleep .3
#plymouth quit --retain-splash

#[ ! -f /run/udev/data/+drm:card0-eDP-1 ] \
# && sudo systemctl restart systemd-udev-trigger > /dev/null
#
#sudo systemctl status iwd|grep Active..active \
# || sudo systemctl start iwd &

#while [ ! -f /run/udev/data/+drm:card0-eDP-1 ] ; do echo "waiting for drm" && sleep 0.2 ; done

# set this variable to the resolution of the hdmi screen
#export HDMIRES=1920x1200@60.00

#export QT_QPA_PLATFORM=wayland-egl
unset QT_QPA_PLATFORM
export QT_QPA_PLATFORMTHEME=kde

export GTK_THEME=Adwaita:dark

#export DISPLAY=:0

export USER=waverider
[ -z $TERM ] && export TERM=linux
[ -z $LOGNAME ] && export LOGNAME=$USER
[ -z $HOME ] && export HOME=/home/$USER
[ -z $LANG ] && export LANG=C.UTF-8
[ -z $PATH ] && export PATH=/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl
[ -z $XDG_SEAT ] && export XDG_SEAT=seat0
[ -z $XDG_SESSION_TYPE ]  && export XDG_SESSION_TYPE=tty
[ -z $XDG_SESSION_CLASS ] && export XDG_SESSION_CLASS=user
[ -z $XDG_VTNR ] && export XDG_VTNR=1
[ -z $XDG_RUNTIME_DIR ] && export XDG_RUNTIME_DIR=/run/user/1000
[ -z $DBUS_SESSION_BUS_ADDRESS ] && export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
export PATH=~/.npm-global/bin:$PATH
export PATH=:/opt/wine-ge-custom/bin:$PATH

#export JAVA_HOME=/usr/lib/jvm/java-21-jdk

export HYPRLAND_LOG_WLR=1
#export XCURSOR_SIZE=24

# change the theme here
#export XCURSOR_THEME=Bibata-Modern-Classic
#export GTK_THEME=Adwaita-amoled-dark-Fix

#[ ! -f /run/udev/data/+drm:card0-eDP-1 ] \
# && echo "Hyprland needs drm, bailing out" && exit -1

exec Hyprland > .hyprland.out.txt 2> .hyprland.err.txt &>> .hyprland.log.txt 
