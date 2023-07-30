----------------------------------
--         ____ _   __ __       --
--        / __// \,' // /       --
--       / _/ / \,' // /_       --
--      /_/  /_/ /_//___/       --
----------------------------------

local awful = require("awful")
local menubar = require("menubar")
local beautiful = require("beautiful")
local wallpaper = require("ui.widgets.wallpaper")

-- {{{ Wibar
-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    wallpaper{
        screen = s
    }
    -- Create wibox bars
    s.mywibox = awful.wibar({ 
        position = "top", 
        bg = beautiful.bg_normal, 
        screen = s 
    })
    
    s.bottomwibox = awful.wibar({ 
        position = "bottom", 
        bg = beautiful.bg_normal, 
        screen = s 
    })
    
    -- Configure wibox bars
    local config_topbar = require("ui.wibars.top")
    config_topbar{
        screen = s
    }
    local config_bottombar = require("ui.wibars.bottom")
    config_bottombar{
        screen = s
    }
end)
-- }}}