--      _       __             _ _
--   __| | ___ / _| __ _ _   _| | |_
--  / _` |/ _ \ |_ / _` | | | | | __|
-- | (_| |  __/  _| (_| | |_| | | |_
--  \__,_|\___|_|  \__,_|\__,_|_|\__|
--               THEME
--
-- By Omar Ahmed (techtycho)

local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi

local themes_path = _G.subdirs.themes

local theme = {}
theme.name = "default"

-- ## COLORS ##
-- Background
theme.bg_normal  = "#282c34"
theme.bg_focus   = "#181c24"
theme.bg_systray = "#383c44"

-- Foreground
theme.fg_normal = "#aaaaaa"
theme.fg_focus  = "#bbbbbb"
theme.fg_urgent = "#ffffff"

-- Border colors
theme.border_color_normal = "#282c34"
theme.border_color_active = "#56b6c2"
theme.border_color_marked = "#e06c75"

-- Widgets
theme.widget_client_stat_color = "#98c379"
theme.widget_volume_color      = "#61afef"
theme.widget_battery_color     = "#c678dd"
theme.widget_language_color    = "#e5c07b"
theme.widget_date_color        = "#e06c75"
theme.widget_clock_color       = "#98c379"
theme.widget_layout_color      = "#ffffff"

-- Systray
theme.widget_systray_color = "#383c44"

-- Client title widget
theme.widget_client_title_separator_color = "#888c94"
theme.widget_client_title_fg              = "#bbbbbb"

-- Taglist
theme.taglist_bg_occupied = "#ffffff0a"
theme.taglist_bg_focus    = "#ffffff20"
theme.taglist_bg_urgent   = "#e06c752f"

theme.taglist_fg          = "#dddddd"
theme.taglist_fg_focus    = "#eeeeee"
theme.taglist_fg_occupied = "#dadada"
theme.taglist_fg_urgent   = "#fff1f1"

theme.taglist_underline_color_normal = "#888888"
theme.taglist_underline_color_focus  = "#61afef"
theme.taglist_underline_color_urgent = "#e06c75"

-- State
theme.hover_bg                  = "#fff1"
theme.widget_volume_color_muted = "#fff4"

-- Effects
theme.tagswitch_bg = "#000"
theme.tagswitch_fg = "#fff"

-- ## WINDOWS ##
theme.useless_gap  = dpi(5)
-- Borders
theme.border_width = dpi(1)

-- ## FONTS ##
theme.font                     = "JetBrainsMono Nerd Font 9"
theme.taglist_font             = "JetBrainsMono Nerd Font 9"
theme.widget_client_title_font = "Liberation Sans 9"
-- Effects
theme.tagswitch_font           = "JetBrainsMono Nerd Font 37"

-- ## BAR ##
theme.bar_height           = 25
theme.widget_spacing       = 6
theme.underline_thickness  = 2
-- Systray
theme.systray_icon_spacing = 3

-- ## WIDGETS ##
theme.widget_volume_icon       = "墳 "
theme.widget_volume_icon_muted = "婢 "
theme.widget_battery_icon      = " "
theme.widget_language_icon     = "韛 "
theme.widget_client_stat_icon  = " "

-- Client title widget
theme.widget_client_title_separator_thickness = 1

-- ## TAGLIST ##
theme.taglist_width               = 9
theme.taglist_underline_thickness = 3

-- ## EFFECTS ## --
-- Tagswitch
theme.tagswitch_height = 100
theme.tagswitch_width  = 110
theme.tagswitch_speed  = 200
theme.tagswitch_delay  = 0.25

-- ## ASSETS ##
theme.wallpaper = themes_path .. "global/wallpapers/fallback.png" -- Fallback wallpaper image

-- Layout Icons (Trailing 'w' represents white variant)
theme.layout_floating  = themes_path .. "global/layouts/floatingw.png"
theme.layout_magnifier = themes_path .. "global/layouts/magnifierw.png"
theme.layout_tile      = themes_path .. "global/layouts/tilew.png"

-- ## NOTIFICATIONS ##
-- TODO Customize notifications
-- Set different colors for urgent notifications.
rnotification.connect_signal("request::rules", function()
  rnotification.append_rule {
    rule       = { urgency = "critical" },
    properties = { bg = "#ff0000", fg = "#ffffff" }
  }
end)

return theme
