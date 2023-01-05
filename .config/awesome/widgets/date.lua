local wibox = require("wibox")

local M = {}

M.widget = wibox.widget {
  {
    {
      {
        format = "%A, %d %b %Y",
        widget = wibox.widget.textclock,
      },
      fg     = "#e06c75",
      widget = wibox.container.background,
    },
    bottom = 2,
    color  = "#e06c75",
    widget = wibox.container.margin,
  },
  right  = 6,
  left   = 6,
  widget = wibox.container.margin,
}

return M
