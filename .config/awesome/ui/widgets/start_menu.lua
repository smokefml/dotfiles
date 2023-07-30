----------------------------------
--         ____ _   __ __       --
--        / __// \,' // /       --
--       / _/ / \,' // /_       --
--      /_/  /_/ /_//___/       --
----------------------------------

local awful = require("awful")
local beautiful = require("beautiful")
local xdg_menu = require("archmenu")
local vars = require("config.vars")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

local start_menu = {}

-- Create a launcher widget and a main menu
start_menu.myawesomemenu = {
    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual", vars.terminal .. " -e man awesome" },
    { "editar config", vars.editor_cmd .. " " .. awesome.conffile },
    { "reiniciar", awesome.restart },
    { "salir", function() awesome.quit() end },
}
 
start_menu.mymainmenu = awful.menu({ items = { { "awesome", start_menu.myawesomemenu, beautiful.awesome_icon },
                                    { "aplicaciones", xdgmenu },
                                    { "abrir terminal", vars.terminal },
                                    { "cambiar wallpaper", "nitrogen" }
                                }
                        })

start_menu.mylauncher = awful.widget.launcher({ image = beautiful.arch_icon,
                                    menu = start_menu.mymainmenu })
-- }}}

return start_menu