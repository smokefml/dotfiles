----------------------------------
--         ____ _   __ __       --
--        / __// \,' // /       --
--       / _/ / \,' // /_       --
--      /_/  /_/ /_//___/       --
----------------------------------

local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local systray = wibox.widget.systray()

local systray_container = {
    systray,
    left = dpi(5),
    right = dpi(5),
    top = dpi(1),
    bottom = dpi(1),
    --bg = beautiful.bg_systray,
    widget = wibox.container.margin
}

local mysystray = wibox.widget {
    {
        systray_container,
        top = dpi(1),
        bottom = dpi(1),
        left = dpi(3),
        right = dpi(3),
        layout = wibox.container.margin
    },
    bg = beautiful.bg_systray,
    shape = gears.shape.rounded_rect,
    widget = wibox.container.background
}

return mysystray