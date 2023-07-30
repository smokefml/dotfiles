----------------------------------
--         ____ _   __ __       --
--        / __// \,' // /       --
--       / _/ / \,' // /_       --
--      /_/  /_/ /_//___/       --
----------------------------------

local wibox = require("wibox")

return wibox.widget.separator{
    orientation = vertical,
    forced_width  = 5,
    forced_height = 24,
    thickness     = 5,
    visible = true,
    opacity = 0,
}