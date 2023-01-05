local wibox = require("wibox")

local M = {}

M.widget = wibox.widget {
  {
    {
      {
        format = "%H:%M",
        widget = wibox.widget.textclock,
      },
      fg     = "#98c379",
      widget = wibox.container.background,
    },
    bottom = 2,
    color  = "#98c379",
    widget = wibox.container.margin,
  },
  right  = 6,
  left   = 6,
  widget = wibox.container.margin,
}

return M
