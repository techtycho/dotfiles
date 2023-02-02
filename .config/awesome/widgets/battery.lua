local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")

local shell = require("util.shell")

local M = {}

M.interval = 15 -- interval for updating the widget, in seconds

-- ## TEMPLATE ##
M.widget = wibox.widget {
  {
    {
      {
        {
          {
            text = beautiful.widget_battery_icon or "",
            widget = wibox.widget.textbox,
          },
          awful.widget.watch(shell.bash("battery"), M.interval),
          {
            text = "%",
            widget = wibox.widget.textbox,
          },
          layout = wibox.layout.fixed.horizontal,
        },
        fg     = beautiful.widget_battery_color or beautiful.fg_color or "#fff",
        widget = wibox.container.background,
      },
      bottom = beautiful.underline_thickness or 2,
      color  = beautiful.widget_battery_color or beautiful.fg_color or "#fff",
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
