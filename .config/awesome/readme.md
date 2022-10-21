# My Awesome config

This config relies on stuff you must install, or it will be broken.

## Awesome widgets

https://github.com/streetturtle/awesome-wm-widgets

## Awesome buttons

https://github.com/streetturtle/awesome-buttons

you need to clone these in your .config/awesome directory since im using them

## Instal some necessary programs

- alacritty
- archlinux-xdg-menu
- nvim
- scrot
- picom
- polkit-gnome
- light
- udiskie

## Make archmenu

xdg_menu --format awesome --root-menu /etc/xdg/menus/arch-applications.menu | sed 's/xterm/alacritty/g' >~/.config/awesome/archmenu.lua
