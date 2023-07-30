-- 8 8888888888       ,8.       ,8.          8 8888         
-- 8 8888            ,888.     ,888.         8 8888         
-- 8 8888           .`8888.   .`8888.        8 8888         
-- 8 8888          ,8.`8888. ,8.`8888.       8 8888         
-- 8 888888888888 ,8'8.`8888,8^8.`8888.      8 8888         
-- 8 8888        ,8' `8.`8888' `8.`8888.     8 8888         
-- 8 8888       ,8'   `8.`88'   `8.`8888.    8 8888         
-- 8 8888      ,8'     `8.`'     `8.`8888.   8 8888         
-- 8 8888     ,8'       `8        `8.`8888.  8 8888         
-- 8 8888    ,8'         `         `8.`8888. 8 888888888888 

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local naughty = require("naughty")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- theme
require("config.theme")

-- layouts
require("config.layouts")

-- User Interface :D
require("ui")

-- mouse bindings
require("config.mouse_bindings")
-- }}}

-- key bindings
require("config.key_bindings")
-- }}}

-- {{{ Rules
require("config.client_rules")
-- }}}

-- {{{ Signals
require("config.client_signals")
-- }}}

-- {{{ Autostart at launch
-- autostart script
awful.spawn.with_shell("~/.config/awesome/autorun.sh")
-- touchpad
awful.spawn.with_shell('~/.local/bin/tpcfg')
-- screen brightness
awful.spawn.with_shell("light -S 35")
-- update menu
awful.spawn.with_shell("xdg_menu --format awesome --root-menu /etc/xdg/menus/arch-applications.menu | sed 's/xterm/alacritty/g' >~/.config/awesome/archmenu.lua")
-- }}}


-- Garbage collector
collectgarbage("setpause", 160)
collectgarbage("setstepmul", 400)

gears.timer.start_new(10, function()
  collectgarbage("step", 20000)
  return true
end)
