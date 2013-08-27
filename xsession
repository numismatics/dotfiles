#!/bin/sh

#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
#

xrandr -s 0

xrdb $HOME/.Xresources

xsetroot -cursor_name left_ptr

xset b off
xset s off
xset -dpms

#apps
trayer --edge top --align right --widthtype request --expand true --SetDockType true --SetPartialStrut true --transparent true --alpha 0 --tint 0x1A1918 --expand true --heighttype pixel --height 18 --padding 1 &
/usr/bin/nm-applet --sm-disable &
VBoxClient-all &
xcompmgr &
feh --bg-scale .config/wallpaper/arch.png &

#call windowmanager
exec xmonad > $HOME/.xmonad/log.txt 2>&1

