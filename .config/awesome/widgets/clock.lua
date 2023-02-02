local wibox     = require("wibox")
local beautiful = require("beautiful")

local M = {}

-- ## TEMPLATE ##
M.widget = wibox.widget {
  {
    {
      {
        {
          id     = "clock",
          format = "%H:%M",
          widget = wibox.widget.textclock,
        },
        fg     = beautiful.widget_clock_color or beautiful.fg_normal or "#fff",
        widget = wibox.container.background,
      },
      bottom = beautiful.underline_thickness or 2,
      color  = beautiful.widget_clock_color or beautiful.fg_normal or "#fff",
      widget = wibox.container.margin,
    },
    right  = beautiful.widget_spacing or 6,
    left   = beautiful.widget_spacing or 6,
    widget = wibox.container.margin,
  },
  widget = wibox.container.background, -- This exists for the hover effect
}

-- ## EFFECTS ##
M.widget:connect_signal("mouse::enter", function()
  M.widget:set_bg(beautiful.hover_bg or "#fff1")
end)

M.widget:connect_signal("mouse::leave", function()
  M.widget:set_bg("#fff0")
end)

return M
