local awful = require("awful")
local wibox = require("wibox")

local shell = require("util.shell")

local M = {}

M.interval = 15

M.widget = wibox.widget {
  {
    {
      {
        {
          text = " ",
          widget = wibox.widget.textbox,
        },
        awful.widget.watch(shell.bash("battery"), M.interval),
        {
          text = "%",
          widget = wibox.widget.textbox,
        },
        layout = wibox.layout.fixed.horizontal,
      },
      fg     = "#c678dd",
      widget = wibox.container.background,
    },
    bottom = 2,
    color  = "#c678dd",
    widget = wibox.container.margin,
  },
  right  = 6,
  left   = 6,
  widget = wibox.container.margin,
}

return M
