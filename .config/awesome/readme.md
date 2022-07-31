# My Awesome config

This config relies on stuff you must install, or it will be broken.

## Awesome widgets

https://github.com/streetturtle/awesome-wm-widgets

you need to clone this repo in your awesome directory since im using some of them

## Instal some necessary programs

- alacritty
- nvim
- scrot
- picom
- polkit-gnome
- light

## Make archmenu

xdg_menu --format awesome --root-menu /etc/xdg/menus/arch-applications.menu | sed 's/xterm/alacritty/g' >~/.config/awesome/archmenu.lua
