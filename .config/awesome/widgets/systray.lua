local wibox     = require("wibox")
local beautiful = require("beautiful")

local M = {}

M.widget = wibox.widget {
  {
    {
      wibox.widget.systray(),
      top    = 3,
      bottom = 3,
      right  = 5,
      left   = 5,
      widget = wibox.container.margin,
    },
    bg     = beautiful.widget_systray_color or beautiful.bg_normal or "#fff",
    widget = wibox.container.background,
  },
  left = beautiful.widget_spacing,
  widget = wibox.container.margin,
}

return M
