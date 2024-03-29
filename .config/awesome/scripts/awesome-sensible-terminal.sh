#!/bin/sh
# Based on i3-sensible-terminal

#
# This code is released in public domain by Han Boetes <han@mijncomputer.nl>
#
# This script tries to exec a terminal emulator by trying some known terminal
# emulators.
#
# We welcome patches that add distribution-specific mechanisms to find the
# preferred terminal emulator. On Debian, there is the x-terminal-emulator
# symlink for example.
#
# Invariants:
# 1. $TERMINAL must come first
# 2. Distribution-specific mechanisms come next, e.g. x-terminal-emulator
# 3. The terminal emulator with best accessibility comes first.
# 4. No order is guaranteed/desired for the remaining terminal emulators.
for terminal in "$TERMINAL" alacritty kitty termite hyper wezterm x-terminal-emulator mate-terminal gnome-terminal terminator xfce4-terminal urxvt rxvt termit Eterm aterm uxterm xterm roxterm lxterminal terminology st qterminal lilyterm tilix terminix konsole guake tilda; do
    if command -v "$terminal" > /dev/null 2>&1; then
        exec "$terminal" "$@"
    fi
done

awesome-client 'local naughty = require("naughty"); naughty.notify { naughty.config.presets.critical, title = "awesome-sensible-terminal", text = "could not find a terminal emulator. Please install one." }'