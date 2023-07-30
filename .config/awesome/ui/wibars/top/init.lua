----------------------------------
--         ____ _   __ __       --
--        / __// \,' // /       --
--       / _/ / \,' // /_       --
--      /_/  /_/ /_//___/       --
----------------------------------

local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local widgets = require("ui.load_widgets")

local mytable = {}

local start_menu = require("ui.widgets.start_menu")
local mylauncher = start_menu.mylauncher
local create_taglist = widgets.create_taglist

local icon_theme = beautiful.icon_theme

local function create_bar(user_args)
    local args = user_args or {}

    local s = args.screen

    -- some widgets
    s.mytaglist = create_taglist{
        screen = s
    }
    s.mypromptbox = awful.widget.prompt()
    local myclockbar = widgets.myclockbar
    local spotify_widget = widgets.spotify_widget
    local mysystray = widgets.mysystray
    local volume_widget = widgets.volume_widget
    local brightness_widget = widgets.brightness_widget
    local battery_widget = widgets.battery_widget
    local separator = widgets.separator_empty_small

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            separator,
            mylauncher,
            separator,
            s.mytaglist,
            s.mypromptbox,
        },
        myclockbar, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spotify_widget({
                play_icon = icon_theme .. "panel/24/spotify-indicator.svg",
                pause_icon = '/usr/share/icons/Papirus-Dark/24x24/panel/spotify-indicator.svg',
                dim_when_paused = true,
                dim_opacity = 0.5,
            }),
            separator,
            mysystray,
            separator,
            volume_widget{
                widget_type = 'arc',
                mixer_cmd = 'pavucontrol',
                device = 'default',
                icon_dir = icon_theme .. "status/symbolic/",
                main_color = beautiful.purple,
            },
            separator,
            brightness_widget{
                base = 35,
                tooltip = true,
                percentage = true,
                path_to_icon = icon_theme .. "status/symbolic/display-brightness-symbolic.svg",
                main_color = beautiful.purple,
            },
            battery_widget{
                path_to_icons = icon_theme .. "status/symbolic/",
            },
            separator,
        },
    }
    -- return mytable
end

return setmetatable(mytable, { __call = function(_, ...)
    return create_bar(...)
end })