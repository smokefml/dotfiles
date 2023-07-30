----------------------------------
--         ____ _   __ __       --
--        / __// \,' // /       --
--       / _/ / \,' // /_       --
--      /_/  /_/ /_//___/       --
----------------------------------

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local widgets = require("ui.load_widgets")
local vars = require("config.vars")

local mytable = {}

local function create_bar(user_args)
    local args = user_args or {}
    
    local s = args.screen
    
    -- some widgets
    local weather_widget = widgets.weather_widget
    -- Tasklist
    local create_tasklist = require("ui.widgets.tasklist")
    s.mytasklist = create_tasklist{
        screen = s
    }
    local mytaskbar = wibox.container.place(
        s.mytasklist,
        'center',
        'center'
    )
    local mykeyboardlayout = widgets.mykeyboardlayout
    local separator = widgets.separator_empty_small

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({ }, 1, function () awful.layout.inc( 1) end),
        awful.button({ }, 3, function () awful.layout.inc(-1) end),
        awful.button({ }, 4, function () awful.layout.inc( 1) end),
        awful.button({ }, 5, function () awful.layout.inc(-1) end)
    ))

    -- Add widgets to the wibox
    s.bottomwibox:setup {
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            weather_widget({
                api_key = vars.weather_key,
                coordinates = {vars.weather_coordx, vars.weather_coordy},
                show_hourly_forecast = true,
                show_daily_forecast = true
            }),
        },
        mytaskbar,
        {
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            separator,
            s.mylayoutbox
        }
    }
    -- return mytable
end

return setmetatable(mytable, { __call = function(_, ...)
    return create_bar(...)
end })