----------------------------------
--         ____ _   __ __       --
--        / __// \,' // /       --
--       / _/ / \,' // /_       --
--      /_/  /_/ /_//___/       --
----------------------------------

return {
    -- My start menu
    start_menu = require("ui.widgets.start_menu"),

    -- Keyboard map indicator and switcher
    mykeyboardlayout = require("ui.widgets.kb_layout"),

    -- my clock
    myclockbar = require("ui.widgets.clock"),

    -- Battery widget
    battery_widget = require("awesome-wm-widgets.battery-widget.battery"),

    -- Spotify widget
    spotify_widget = require("awesome-wm-widgets.spotify-widget.spotify"),

    -- volume controls
    volume_widget = require('awesome-wm-widgets.volume-widget.volume'),

    -- -- weather widget
    weather_widget = require("awesome-wm-widgets.weather-widget.weather"),

    -- laptop brightness library
    brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness"),

    -- System Tray with background
    mysystray = require("ui.widgets.systray"),

    -- Tag List
    create_taglist =  require("ui.widgets.taglist"),

    -- Separators
    separator_empty_small =  require("ui.widgets.separator_empty_small"),
}