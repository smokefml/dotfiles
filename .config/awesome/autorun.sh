#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

if ! pgrep udiskie ;
then
  udiskie -t &
fi

# eval 'ssh-agent -s'
run "nm-applet"
run "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
run "xfce4-clipman"
