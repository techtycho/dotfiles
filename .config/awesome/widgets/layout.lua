local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")

local M = {}

M.init = function(s)
  -- ## TEMPLATE ##
  local widget = wibox.widget {
    {
      {
        {
          awful.widget.layoutbox {
            screen = s,
          },
          top    = 3,
          bottom = 4,
          widget = wibox.container.margin,
        },
        bottom = beautiful.underline_thickness,
        color  = beautiful.widget_layout_color or "#fff",
        widget = wibox.container.margin,
      },
      left   = beautiful.widget_spacing or 6,
      right  = beautiful.widget_spacing or 6,
      widget = wibox.container.margin,
    },
    widget = wibox.container.background,
  }

  -- ## EFFECTS ##
  widget:connect_signal("mouse::enter", function()
    widget:set_bg(beautiful.hover_bg or "#fff1")
  end)

  widget:connect_signal("mouse::leave", function()
    widget:set_bg("#fff0")
  end)

  -- ## LOGIC ##
  widget.buttons = {
    awful.button({}, 1, function() awful.layout.inc(1) end),
    awful.button({}, 3, function() awful.layout.inc(-1) end),
    awful.button({}, 4, function() awful.layout.inc(-1) end),
    awful.button({}, 5, function() awful.layout.inc(1) end),
  }

  return widget
end

return M
