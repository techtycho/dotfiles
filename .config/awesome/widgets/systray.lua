local wibox = require("wibox")

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
    bg     = "#383c44",
    widget = wibox.container.background,
  },
  left = 3,
  widget = wibox.container.margin,
}

return M
