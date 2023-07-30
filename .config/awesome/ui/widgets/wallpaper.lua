----------------------------------
--         ____ _   __ __       --
--        / __// \,' // /       --
--       / _/ / \,' // /_       --
--      /_/  /_/ /_//___/       --
----------------------------------

local awful = require("awful")
local beautiful = require("beautiful")

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

local mytable = {}

local function setwp(user_args)
    local args = user_args or {}

    local s = args.screen

    set_wallpaper(s)

end

return setmetatable(mytable, { __call = function(_, ...)
    return setwp(...)
end })