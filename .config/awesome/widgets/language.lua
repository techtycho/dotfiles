local awful = require("awful")
local wibox = require("wibox")

local language = require("modules.language")

local M = {}

M.widget = wibox.widget {
  {
    {
      {
        {
          text   = "韛 ",
          widget = wibox.widget.textbox
        },
        {
          id     = "content",
          text   = "EN",
          halign = "center",
          valign = "center",
          widget = wibox.widget.textbox
        },
        layout = wibox.layout.fixed.horizontal,
      },
      fg     = "#e5c07b",
      widget = wibox.container.background,
    },
    bottom = 2,
    color  = "#e5c07b",
    widget = wibox.container.margin,
  },
  right  = 6,
  left   = 6,
  widget = wibox.container.margin,
}

M.updateText = function()
  M.widget:get_children_by_id("content")[1]:set_text(language.get())
end

M.switch = function()
  language.switch()
  M.updateText()
end

M.widget.buttons = {
  awful.button({}, 1, function()
    M.switch()
  end)
}

language.signals:connect_signal("language::switch", function()
  M.updateText()
end)

return M
