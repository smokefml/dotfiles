----------------------------------
--         ____ _   __ __       --
--        / __// \,' // /       --
--       / _/ / \,' // /_       --
--      /_/  /_/ /_//___/       --
----------------------------------

local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

-- Themes define colours, icons, font and wallpapers.
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), "dracula")
beautiful.init(theme_path)
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