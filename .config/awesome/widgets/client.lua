local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")

local M = {}

M.init = function(s)
  local widget = awful.widget.tasklist {
    screen = s,
    filter = awful.widget.tasklist.filter.focused,
    style = {
      font     = beautiful.widget_client_font or beautiful.font or "sans 9",
      fg_focus = beautiful.widget_client_fg or beautiful.fg_normal or "#bbb",
      bg_focus = "#fff0",
    },
    widget_template = {
      {
        {
          {
            {
              id     = "text_role",
              widget = wibox.widget.textbox,
            },
            left = 10,
            widget = wibox.container.margin,
          },
          left = beautiful.widget_client_separator_thickness or beautiful.underline_thickness or 1,
          color = beautiful.widget_client_separator_color or beautiful.fg_normal or "#fff",
          widget = wibox.container.margin
        },
        id     = "background_role",
        widget = wibox.container.background,
      },
      top    = 4,
      bottom = 4,
      left   = 10,
      widget = wibox.container.margin,
    },
  }

  -- Disable tasklist symbols
  beautiful.tasklist_plain_task_name = true

  return widget
end

return M
