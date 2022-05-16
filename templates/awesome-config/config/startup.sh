#!/bin/sh
# This is from the Arch wiki
# https://wiki.archlinux.org/title/Awesome#Autostart

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

# To add to autostart, just add "run program [arguments]"
run flameshot
run picom --config ~/.config/awesome/assets/picom.conf
