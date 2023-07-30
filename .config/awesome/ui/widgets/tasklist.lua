----------------------------------
--         ____ _   __ __       --
--        / __// \,' // /       --
--       / _/ / \,' // /_       --
--      /_/  /_/ /_//___/       --
----------------------------------

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local vars = require("config.vars")
local modkey = vars.modkey

-- taglist buttons

local tasklist_buttons = gears.table.join(
    awful.button({ }, 1, function (c)
                            if c == client.focus then
                                c.minimized = true
                            else
                                c:emit_signal(
                                    "request::activate",
                                    "tasklist",
                                    {raise = true}
                                )
                            end
                        end),
    awful.button({ }, 3, function()
                            awful.menu.client_list({ theme = { width = 250 } })
                        end),
    awful.button({ }, 4, function ()
                            awful.client.focus.byidx(1)
                        end),
    awful.button({ }, 5, function ()
                            awful.client.focus.byidx(-1)
                        end)
)

local mytasklist = {}

local function create_tasklist(user_args)
    local args = user_args or {}

    local s = args.screen

    -- Create a tasklist widget
    mytasklist = awful.widget.tasklist {
        screen   = s,
        filter   = awful.widget.tasklist.filter.currenttags,
        buttons  = tasklist_buttons,
        style    = {
            shape_border_width = 1,
            shape_border_color = '#777777',
            shape  = gears.shape.rounded_rect,
        },
        layout   = {
            spacing = 5,
            layout  = wibox.layout.flex.horizontal,
        },

        widget_template = {
            {
                {
                    {
                        {
                            id     = 'icon_role',
                            widget = wibox.widget.imagebox,
                        },
                        top = 2,
                        bottom = 2,
                        left = 2,
                        right = 10,
                        widget  = wibox.container.margin,
                    },
                    {
                        id     = 'text_role',
                        widget = wibox.widget.textbox,
                        align = 'left',
                        forced_width = 260
                    },
                    layout = wibox.layout.align.horizontal,
                    -- max_widget_size = 160
                },
                left  = 10,
                right = 10,
                widget = wibox.container.margin
            },
            id     = 'background_role',
            widget = wibox.container.background,
        },
    }
    return mytasklist
end

return setmetatable(mytasklist, { __call = function(_, ...)
    return create_tasklist(...)
end })