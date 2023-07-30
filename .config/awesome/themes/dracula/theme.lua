---------------------------------
--  "dracula" awesome theme  --
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
theme.wallpaper = themes_path .. "dracula/dracula-background.png"
-- }}}

-- {{{ Styles
theme.font      = "sans 10"
--theme.notification_shape = gears.shape.rounded_ret

-- {{{ Colors
-- Dracula base colors
theme.background         = "#282a36"
theme.current_line       = "#44475a"
theme.foreground         = "#f8f8f2"
theme.comment            = "#6272a4"
theme.cyan               ="#8be9fd"
theme.green              = "#50fa7b"
theme.orange             = "#ffb86c"
theme.pink               = "#ff79c6"
theme.purple             = "#bd93f9"
theme.red                = "#ff5555"
theme.yellow             = "#f1fa8c"
-- Dracula ANSI colors
theme.ansi_black         = "#21222C"
theme.ansi_red           = "#FF5555"
theme.ansi_green         = "#50FA7B"
theme.ansi_yellow        = "#F1FA8C"
theme.ansi_blue          = "#BD93F9"
theme.ansi_magenta       = "#FF79C6"
theme.ansi_cyan          = "#8BE9FD"
theme.ansi_white         = "#F8F8F2"
theme.ansi_brightBlack   = "#6272A4"
theme.ansi_brightRed     = "#FF6E6E"
theme.ansi_brightGreen   = "#69FF94"
theme.ansi_brightYellow  = "#FFFFA5"
theme.ansi_brightBlue    = "#D6ACFF"
theme.ansi_brightMagenta = "#FF92DF"
theme.ansi_brightCyan    = "#A4FFFF"
theme.ansi_brightWhite   = "#FFFFFF"


theme.fg_normal  = theme.foreground
theme.fg_focus   = theme.green
theme.fg_urgent  = theme.orange
theme.bg_normal  = string.format("%s77",theme.background)
theme.bg_focus   = string.format("%scc",theme.current_line)
theme.bg_urgent  = string.format("%sdd",theme.background)
theme.bg_systray = theme.bg_normal
-- }}}

-- {{{ Borders
theme.useless_gap   = dpi(2)
theme.border_width  = dpi(2)
theme.border_normal = theme.background
theme.border_focus  = theme.purple
theme.border_marked = theme.orange
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = theme.current_line
theme.titlebar_bg_normal = theme.background
-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
-- theme.taglist_bg_focus = theme.current_line
--theme.taglist_fg_focus = '#bd93f9'
-- theme.tasklist_bg_focus = theme.background
theme.tasklist_fg_focus = theme.pink
theme.tasklist_shape_border_color_focus = theme.tasklist_fg_focus
theme.tasklist_bg_minimize = theme.background .. "55"
theme.tasklist_fg_minimize = theme.comment
theme.tasklist_font_focus = "Sans Bold 10"

theme.taglist_shape_border_width_focus = dpi(1)
theme.taglist_shape_border_color_focus = theme.pink
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
theme.mouse_finder_color = theme.orange
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
-- theme.icon_theme = "/usr/share/icons/Arc/"
theme.icon_theme = "~/.local/share/icons/MB-Plum-Suru-GLOW/"
-- {{{ Taglist
theme.taglist_squares_sel   = themes_path .. "dracula/taglist/squarefz.png"
theme.taglist_squares_unsel = themes_path .. "dracula/taglist/squarez.png"

theme.icon_home_tag = theme.icon_theme .. "categories/24/terminal.svg"
theme.icon_www_tag = theme.icon_theme .. "categories/24/internet-web-browser.svg"
theme.icon_dev_tag = theme.icon_theme .. "categories/24/code.svg"
theme.icon_office_tag = theme.icon_theme .. "categories/24/clipboard.svg"
theme.icon_chat_tag = theme.icon_theme .. "categories/24/telegram.svg"
theme.icon_music_tag = theme.icon_theme .. "categories/24/music.svg"
theme.icon_game_tag = theme.icon_theme .. "categories/24/gamehub.svg"
theme.icon_video_tag = theme.icon_theme .. "places/24/folder-videos.svg"
theme.icon_misc_tag = theme.icon_theme .. "categories/24/broom.svg"

--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = themes_path .. "dracula/awesome-icon.png"
theme.arch_icon              = theme.icon_theme .. "categories/24/archlinux.svg"
theme.menu_submenu_icon      = themes_path .. "dracula/submenu.png"
-- }}}

-- {{{ Layout
theme.layout_tile       = themes_path .. "dracula/layouts/tile.png"
theme.layout_tileleft   = themes_path .. "dracula/layouts/tileleft.png"
theme.layout_tilebottom = themes_path .. "dracula/layouts/tilebottom.png"
theme.layout_tiletop    = themes_path .. "dracula/layouts/tiletop.png"
theme.layout_fairv      = themes_path .. "dracula/layouts/fairv.png"
theme.layout_fairh      = themes_path .. "dracula/layouts/fairh.png"
theme.layout_spiral     = themes_path .. "dracula/layouts/spiral.png"
theme.layout_dwindle    = themes_path .. "dracula/layouts/dwindle.png"
theme.layout_max        = themes_path .. "dracula/layouts/max.png"
theme.layout_fullscreen = themes_path .. "dracula/layouts/fullscreen.png"
theme.layout_magnifier  = themes_path .. "dracula/layouts/magnifier.png"
theme.layout_floating   = themes_path .. "dracula/layouts/floating.png"
theme.layout_cornernw   = themes_path .. "dracula/layouts/cornernw.png"
theme.layout_cornerne   = themes_path .. "dracula/layouts/cornerne.png"
theme.layout_cornersw   = themes_path .. "dracula/layouts/cornersw.png"
theme.layout_cornerse   = themes_path .. "dracula/layouts/cornerse.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus  = themes_path .. "dracula/titlebar/close_focus.png"
theme.titlebar_close_button_normal = themes_path .. "dracula/titlebar/close_normal.png"

theme.titlebar_minimize_button_normal = themes_path .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path .. "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_focus_active  = themes_path .. "dracula/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = themes_path .. "dracula/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path .. "dracula/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = themes_path .. "dracula/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = themes_path .. "dracula/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = themes_path .. "dracula/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path .. "dracula/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = themes_path .. "dracula/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = themes_path .. "dracula/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = themes_path .. "dracula/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = themes_path .. "dracula/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = themes_path .. "dracula/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = themes_path .. "dracula/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = themes_path .. "dracula/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path .. "dracula/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = themes_path .. "dracula/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
