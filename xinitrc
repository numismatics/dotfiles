#!/bin/sh

#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
#

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Start GNOME Keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)

export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID

xrandr -s 0

xrdb $HOME/.Xresources

xsetroot -cursor_name left_ptr

xset b off
xset s off
xset -dpms

# ex ante programs
trayer --edge top --align right --widthtype request --expand true --SetDockType true --SetPartialStrut true --transparent true --alpha 0 --tint 0x1A1918 --expand true --heighttype pixel --height 18 --padding 1 &
VBoxClient-all &
xcompmgr &
feh --bg-scale .config/wallpaper/arch.png &

#epoch: call windowmanager
#exec xmonad > $HOME/.xmonad/log.txt 2>&1

#ex post programs
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & 
nm-applet &
/usr/lib/notification-daemon-1.0/notification-daemon &
exec xmonad > $HOME/.xmonad/log.txt 2>&1
