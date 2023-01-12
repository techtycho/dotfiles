local awful = require("awful")
local wibox = require("wibox")

local M = {}

M.init = function(s)
  return wibox.widget {
    {
      {
        markup = "[",
        font   = "JetBrainsMono Nerd Font 12",
        widget = wibox.widget.textbox,
      },
      {
        awful.widget.layoutbox {
          screen  = s,
          buttons = {
            awful.button({}, 1, function() awful.layout.inc(1) end),
            awful.button({}, 3, function() awful.layout.inc(-1) end),
            awful.button({}, 4, function() awful.layout.inc(-1) end),
            awful.button({}, 5, function() awful.layout.inc(1) end),
          },
        },
        top    = 3,
        bottom = 2,
        widget = wibox.container.margin,
      },
      {
        markup = "]",
        font   = "JetBrainsMono Nerd Font 12",
        widget = wibox.widget.textbox,
      },
      layout = wibox.layout.fixed.horizontal,
    },
    left   = 3,
    right  = 3,
    bottom = 2,
    widget = wibox.container.margin,
  }
end

return M
