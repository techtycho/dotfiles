local wibox     = require("wibox")
local beautiful = require("beautiful")

local M = {}

-- ## TEMPLATE ##
M.widget = wibox.widget {
  {
    {
      {
        {
          format = "%A, %d %b %Y",
          widget = wibox.widget.textclock,
        },
        fg     = beautiful.widget_date_color or beautiful.fg_color or "#fff",
        widget = wibox.container.background,
      },
      bottom = beautiful.underline_thickness or 2,
      color  = beautiful.widget_date_color or beautiful.fg_color or "#fff",
      widget = wibox.container.margin,
    },
    right  = beautiful.widget_spacing or 6,
    left   = beautiful.widget_spacing or 6,
    widget = wibox.container.margin,
  },
  widget = wibox.container.background,
}

-- ## EFFECTS ##
M.widget:connect_signal("mouse::enter", function()
  M.widget:set_bg(beautiful.hover_bg or "#fff1")
end)

M.widget:connect_signal("mouse::leave", function()
  M.widget:set_bg("#fff0")
end)

return M
