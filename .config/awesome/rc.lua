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
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- logout buttons popup library
local logout_popup = require("awesome-wm-widgets.logout-popup-widget.logout-popup")
-- laptop brightness library
local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")
-- volume controls
local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
-- calendar
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
-- XDG menu
local xdg_menu = require("archmenu")
-- weather widget
local weather_widget = require("awesome-wm-widgets.weather-widget.weather")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

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

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), "blackburn")
beautiful.init(theme_path)
-- define dpi to correct scalating sizes
local dpi = require("beautiful.xresources").apply_dpi
-- notifications theme variables
beautiful.notification_shape = gears.shape.rounded_rect
beautiful.notification_opacity = 0.8
-- menu theme variables
awful.menu.original_new = awful.menu.new
function awful.menu.new(...)
  local ret= awful.menu.original_new(...)
  ret.wibox.shape = function (cr, w, h)
    gears.shape.rounded_rect(cr, w, h, 6)
  end
  return ret
end
-- This is used later as the default terminal and editor to run.
--terminal = "alacritty -o font.size=8"
local terminal = "alacritty"
local editor = os.getenv("EDITOR") or "nano"
local editor_cmd = terminal .. " -e " .. editor
local guieditor = "code-oss --unity-launch"
local guifileexplorer = "nemo"
local musicplayer = "spotify-launcher"
--spotify = "ncspot"
--spotify_cmd = terminal .. " -e " .. spotify

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
local modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
local myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "editar config", editor_cmd .. " " .. awesome.conffile },
   { "reiniciar", awesome.restart },
   { "salir", function() awesome.quit() end },
}

local mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "aplicaciones", xdgmenu },
                                    { "abrir terminal", terminal },
                                    { "cambiar wallpaper", "nitrogen" }
                                  }
                        })

local mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
local mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
local mytextclock = wibox.widget.textclock()
-- A container for the clock
local myclockbar = wibox.container.place(
    mytextclock,
    'center',
    'center'
)
-- Calendar attached to clock
local cw = calendar_widget({
    theme = 'nord',
    placement = 'top_center',
    start_sunday = true,
    radius = 8,
})
mytextclock:connect_signal("button::press",
    function(_, _, _, button)
        if button == 1 then cw.toggle() end
    end)
-- Battery widget
local battery_widget = require("awesome-wm-widgets.battery-widget.battery")

-- Spotify widget
local spotify_widget = require("awesome-wm-widgets.spotify-widget.spotify")

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
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
--    if beautiful.wallpaper then
--        local wallpaper = beautiful.wallpaper
--        -- If wallpaper is a function, call it with the screen
--        if type(wallpaper) == "function" then
--            wallpaper = wallpaper(s)
--        end
--        gears.wallpaper.maximized(wallpaper, s, true)
--    end
    awful.spawn.with_shell("nitrogen --restore")
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    --awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
    local names = { "main", "www", "dev", "office", "chat", "music", "game", "video", "misc" }
    local l = awful.layout.suit
    local layouts = { l.fair, l.tile, l.tile, l.tile, l.tile, l.fair, l.floating, l.floating, l.floating }
    local icons_path = "/usr/share/icons/Arc/"
    local icons = {
        icons_path .. "actions/24/go-home.png",
        icons_path .. "categories/24/applications-internet.png",
        icons_path .. "actions/24/system-run.png",
        icons_path .. "actions/24/mail-attachment.png",
        icons_path .. "panel/22/user-available.svg",
        icons_path .. "actions/24/music-library.png",
        icons_path .. "devices/24/input-gaming.png",
        icons_path .. "places/24/folder-videos.png",
        icons_path .. "actions/24/mail-mark-junk.png"
    }
    awful.tag.add(names[1], {
        icon               = icons[1],
        layout             = layouts[1],
        -- master_fill_policy = "master_width_factor",
        -- gap_single_client  = true,
        --gap                = 15,
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
    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
   
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
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

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
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

    local mytaskbar = wibox.container.place(
        s.mytasklist,
        'center',
        'center'
    )

    -- System Tray with background
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

    -- Create the wibox
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

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
	        -- s.mytasklist,
        },
        myclockbar, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spotify_widget({
                play_icon = '/usr/share/icons/Papirus-Light/24x24/categories/spotify.svg',
                pause_icon = '/usr/share/icons/Papirus-Dark/24x24/panel/spotify-indicator.svg',
                dim_when_paused = true,
                dim_opacity = 0.5,
            }),
            wibox.widget.separator{
                orientation = vertical,
                forced_width  = 5,
                forced_height = 24,
                thickness     = 5,
                visible = true,
                opacity = 0,
            },
            mysystray,
            wibox.widget.separator{
                orientation = vertical,
                forced_width  = 5,
                forced_height = 24,
                thickness     = 5,
                visible = true,
                opacity = 0,
            },
            volume_widget{
			    widget_type = 'arc',
			    mixer_cmd = 'pavucontrol',
			    device = 'default'
		    },
            wibox.widget.separator{
                orientation = vertical,
                forced_width  = 5,
                forced_height = 24,
                thickness     = 5,
                visible = true,
                opacity = 0,
            },
            brightness_widget{
                base = 35,
                tooltip = true,
                percentage = true,
            },
	        battery_widget(),
            wibox.widget.separator{
                orientation = vertical,
                forced_width  = 5,
                forced_height = 24,
                thickness     = 5,
                visible = true,
                opacity = 0,
            },
        },
    }

    s.bottomwibox:setup {
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            weather_widget({
                api_key='3cfb956e0bee5d2fc7a4dcdcdb5396ba',
                coordinates = {-26.8584, -65.1652},
                show_hourly_forecast = true,
                show_daily_forecast = true
            }),
        },
        mytaskbar,
        {
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            wibox.widget.separator{
                orientation = vertical,
                forced_width  = 5,
                forced_height = 24,
                thickness     = 5,
                visible = true,
                opacity = 0,
            },
            s.mylayoutbox
        }
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    -- My keys
    -- screen brightness
    awful.key({ }, "XF86MonBrightnessUp", function () 
        brightness_widget:inc() 
    end),
    awful.key({ }, "XF86MonBrightnessDown", function () 
        brightness_widget:dec() 
    end),
    -- volume controls
    awful.key({ }, "XF86AudioRaiseVolume", function() 
        volume_widget:inc(5) 
    end),
    awful.key({ }, "XF86AudioLowerVolume", function() 
        volume_widget:dec(5) 
    end),
    awful.key({ }, "XF86AudioMute", function() 
        volume_widget:toggle() 
    end),
   -- Media Keys
    awful.key({ }, "XF86AudioPlay", function()
       awful.util.spawn("playerctl play-pause", false) 
    end),
    awful.key({ }, "XF86AudioNext", function()
       awful.util.spawn("playerctl next", false) 
    end),
    awful.key({ }, "XF86AudioPrev", function()
       awful.util.spawn("playerctl previous", false) 
    end),
    -- logoff menu
     awful.key({ modkey }, "Delete", function() logout_popup.launch{
            onlock = function() awful.spawn.with_shell('i3lock-fancy') end,
            onsuspend = function() awful.util.spawn("notify-send \"SYSTEM\" \"Suspend function disabled!\"", false) end
        } end,
              {description = "Show logout screen", group = "awesome"}),
    -- Screenshot
        awful.key({ }, "Print", function()
        awful.spawn.with_shell("screenshot")
        awful.util.spawn("notify-send \"SCROT\" \"Screenshot created!\"", false)
    end),
        awful.key({ modkey, "Shift" }, "Print", nil, function()
        awful.spawn.with_shell("scrnshtzone")
    end),
    -- File Browser
    awful.key({ modkey },            "z",     function () awful.util.spawn(guifileexplorer) end,
              {description = "Files", group = "Apps"}),
    -- Browser
    awful.key({ modkey },            "b",     function () awful.util.spawn("firefox") end,
              {description = "Firefox", group = "Apps"}),
    awful.key({ modkey, "Shift" },   "b",     function () awful.util.spawn("firefox -P work") end,
              {description = "Firefox", group = "Apps"}),
    -- Music
    awful.key({ modkey },            "e",     function () awful.spawn(musicplayer) end,
              {description = "Spotify", group = "Apps"}),
    -- GUI Editor
    awful.key({ modkey },            "v",     function () awful.spawn(guieditor) end,
              {description = "Visual Studio Code", group = "Apps"}),
    -- Show help
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    -- Tag Actions
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
    -- Client actions
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "y", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "y", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer",
	        "pavucontrol",
          "Pavucontrol",
          "nitrogen",
          "Nitrogen",
  },

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
          "toolbox",     -- Firefox Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "firefox" },
    --   properties = { screen = 1, tag = "www" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- shape of the client window
    c.shape = gears.shape.rounded_rect
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{ Autostart at launch
-- autostart script
awful.spawn.with_shell("~/.config/awesome/autorun.sh")

--awful.spawn.with_shell("killall udiskie")
-- touchpad
awful.spawn.with_shell('~/.local/bin/tpcfg')
-- brillo de la pantalla
awful.spawn.with_shell("light -S 35")
-- compositor
awful.spawn.with_shell("picom --experimental-backends")
-- wifi
--awful.spawn.with_shell("nm-applet")
-- pendrives
--awful.spawn.with_shell("udiskie -t")
-- polkit agent
--awful.spawn.with_shell("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &")
-- actualizar menu
awful.spawn.with_shell("xdg_menu --format awesome --root-menu /etc/xdg/menus/arch-applications.menu | sed 's/xterm/alacritty/g' >~/.config/awesome/archmenu.lua")
-- }}}
