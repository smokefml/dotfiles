---------------------------------
--  "Blackburn" awesome theme  --
--        ____ _   __ __       --
--       / __// \,' // /       --
--      / _/ / \,' // /_       --
--     /_/  /_/ /_//___/       --
---------------------------------

--local themes_path = require("gears.filesystem").get_themes_dir()
local themes_path = "~/.config/awesome/themes/"
local dpi = require("beautiful.xresources").apply_dpi

-- {{{ Main
local theme = {}
theme.wallpaper = themes_path .. "blackburn/blackburn-background.png"
-- }}}

-- {{{ Styles
theme.font      = "sans 10"
--theme.notification_shape = gears.shape.rounded_ret

-- {{{ Colors
theme.fg_normal  = "#d3cfca"
theme.fg_focus   = "#ffffff"
theme.fg_urgent  = "#deb26c"
theme.bg_normal  = "#070d1477"
theme.bg_focus   = "#2c2c87cc"
theme.bg_urgent  = "#070d14dd"
theme.bg_systray = theme.bg_normal
-- }}}

-- {{{ Borders
theme.useless_gap   = dpi(2)
theme.border_width  = dpi(2)
theme.border_normal = "#070d14"
theme.border_focus  = "#0081c2"
theme.border_marked = "#deb26c"
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#1e1e22"
theme.titlebar_bg_normal = "#070d14"
-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#deb26c"
--theme.taglist_bg_focus = '#0081c2'
--theme.tasklist_bg_focus = theme.taglist_bg_focus
--theme.tasklist_fg_focus = theme.fg_focus
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#070d14"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#deb26c"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = dpi(20)
theme.menu_width  = dpi(150)
-- }}}

-- {{{ Icons
-- {{{ Taglist
theme.taglist_squares_sel   = themes_path .. "blackburn/taglist/squarefz.png"
theme.taglist_squares_unsel = themes_path .. "blackburn/taglist/squarez.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = themes_path .. "blackburn/awesome-icon.png"
theme.menu_submenu_icon      = themes_path .. "blackburn/submenu.png"
-- }}}

-- {{{ Layout
theme.layout_tile       = themes_path .. "blackburn/layouts/tile.png"
theme.layout_tileleft   = themes_path .. "blackburn/layouts/tileleft.png"
theme.layout_tilebottom = themes_path .. "blackburn/layouts/tilebottom.png"
theme.layout_tiletop    = themes_path .. "blackburn/layouts/tiletop.png"
theme.layout_fairv      = themes_path .. "blackburn/layouts/fairv.png"
theme.layout_fairh      = themes_path .. "blackburn/layouts/fairh.png"
theme.layout_spiral     = themes_path .. "blackburn/layouts/spiral.png"
theme.layout_dwindle    = themes_path .. "blackburn/layouts/dwindle.png"
theme.layout_max        = themes_path .. "blackburn/layouts/max.png"
theme.layout_fullscreen = themes_path .. "blackburn/layouts/fullscreen.png"
theme.layout_magnifier  = themes_path .. "blackburn/layouts/magnifier.png"
theme.layout_floating   = themes_path .. "blackburn/layouts/floating.png"
theme.layout_cornernw   = themes_path .. "blackburn/layouts/cornernw.png"
theme.layout_cornerne   = themes_path .. "blackburn/layouts/cornerne.png"
theme.layout_cornersw   = themes_path .. "blackburn/layouts/cornersw.png"
theme.layout_cornerse   = themes_path .. "blackburn/layouts/cornerse.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus  = themes_path .. "blackburn/titlebar/close_focus.png"
theme.titlebar_close_button_normal = themes_path .. "blackburn/titlebar/close_normal.png"

theme.titlebar_minimize_button_normal = themes_path .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path .. "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_focus_active  = themes_path .. "blackburn/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = themes_path .. "blackburn/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path .. "blackburn/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = themes_path .. "blackburn/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = themes_path .. "blackburn/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = themes_path .. "blackburn/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path .. "blackburn/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = themes_path .. "blackburn/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = themes_path .. "blackburn/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = themes_path .. "blackburn/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = themes_path .. "blackburn/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = themes_path .. "blackburn/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = themes_path .. "blackburn/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = themes_path .. "blackburn/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path .. "blackburn/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = themes_path .. "blackburn/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
