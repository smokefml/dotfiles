----------------------------------
--         ____ _   __ __       --
--        / __// \,' // /       --
--       / _/ / \,' // /_       --
--      /_/  /_/ /_//___/       --
----------------------------------

local wibox = require("wibox")
-- calendar
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")

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
    theme = 'dracula',
    placement = 'top_center',
    start_sunday = true,
    radius = 8,
})
mytextclock:connect_signal("button::press",
    function(_, _, _, button)
        if button == 1 then cw.toggle() end
    end)

return myclockbar