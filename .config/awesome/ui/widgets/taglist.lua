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

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

-- Each screen has its own tag table.
local names = { 
    "main", 
    "www", 
    "dev", 
    "office", 
    "chat", 
    "music", 
    "game", 
    "video", 
    "misc" 
}
local l = awful.layout.suit
local layouts = { 
    l.fair, 
    l.tile, 
    l.tile, 
    l.max, 
    l.max, 
    l.tile, 
    l.floating, 
    l.floating, 
    l.floating 
}
local icons = {
    beautiful.icon_home_tag,
    beautiful.icon_www_tag,
    beautiful.icon_dev_tag,
    beautiful.icon_office_tag,
    beautiful.icon_chat_tag,
    beautiful.icon_music_tag,
    beautiful.icon_game_tag,
    beautiful.icon_video_tag,
    beautiful.icon_misc_tag,
}

local mytaglist = {}

local function create_taglist(user_args)
    local args = user_args or {}

    local s = args.screen

    awful.tag.add(names[1], {
        icon               = icons[1],
        layout             = layouts[1],
        screen             = s,
        selected           = true,
    })
    awful.tag.add(names[2], {
        icon = icons[2],
        layout = layouts[2],
        screen = s,
    })
    awful.tag.add(names[3], {
        icon = icons[3],
        layout = layouts[3],
        screen = s,
    })
    awful.tag.add(names[4], {
        icon = icons[4],
        layout = layouts[4],
        screen = s,
    })
    awful.tag.add(names[5], {
        icon = icons[5],
        layout = layouts[5],
        screen = s,
    })
    awful.tag.add(names[6], {
        icon = icons[6],
        layout = layouts[6],
        screen = s,
    })
    awful.tag.add(names[7], {
        icon = icons[7],
        layout = layouts[7],
        screen = s,
    })
    awful.tag.add(names[8], {
        icon = icons[8],
        layout = layouts[8],
        screen = s,
    })
    awful.tag.add(names[9], {
        icon = icons[9],
        layout = layouts[9],
        screen = s,
    })
    
    -- Create a taglist widget
    mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        style   = {
            shape_border_width = dpi(1),
            shape_border_color = '#00000000',
            shape  = gears.shape.rounded_rect,
        },
        layout   = {
            spacing_widget = {
                {
                    forced_width  = 5,
                    forced_height = 24,
                    thickness     = 1,
                    color         = '#777777',
                    widget        = wibox.widget.separator
                },
                valign = 'center',
                halign = 'center',
                widget = wibox.container.place,
            },
            spacing = 3,
            layout  = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    {
                        {
                            id     = 'icon_role',
                            widget = wibox.widget.imagebox,
                        },
                        margins = 2,
                        widget  = wibox.container.margin,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = 1,
                right = 1,
                widget = wibox.container.margin
            },
            id     = 'background_role',
            widget = wibox.container.background,
            -- Add support for hover colors and an index label
    --            create_callback = function(self, c3, index, objects) --luacheck: no unused args
    --                self:get_children_by_id('icon_role')[1].tag = t
    --                self:connect_signal('mouse::enter', function()
    --                    if self.bg ~= beautiful.border_focus then
    --                        self.backup     = self.bg
    --                        self.has_backup = true
    --                    end
    --                    self.bg = beautiful.border_focus
    --                end)
    --                self:connect_signal('mouse::leave', function()
    --                    if self.has_backup then self.bg = self.backup end
    --                end)
    --            end,
    --            update_callback = function(self, c3, index, objects) --luacheck: no unused args
    --                self:get_children_by_id('icon_role')[1].tag = t
    --            end,
        },
    }
    
    return mytaglist
end

return setmetatable(mytaglist, { __call = function(_, ...)
    return create_taglist(...)
end })