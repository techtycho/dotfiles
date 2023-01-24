local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local naughty   = require("naughty")

local language = require("modules.language")

local M = {}

-- ## TEMPLATE ##
M.widget = wibox.widget {
  {
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
        fg     = beautiful.widget_language_color or beautiful.fg_normal or "#fff",
        widget = wibox.container.background,
      },
      bottom = beautiful.underline_thickness or 2,
      color  = beautiful.widget_language_color or beautiful.fg_normal or "#fff",
      widget = wibox.container.margin,
    },
    right  = beautiful.widget_margin or 6,
    left   = beautiful.widget_margin or 6,
    widget = wibox.container.margin,
  },
  widget = wibox.container.background, -- This exists for the hover effects
}

-- ## EFFECTS ##
M.widget:connect_signal("mouse::enter", function()
  M.widget:set_bg(beautiful.hover_bg or "#fff1")
end)

M.widget:connect_signal("mouse::leave", function()
  M.widget:set_bg("#fff0")
end)

M.tooltip = awful.tooltip {
  objects = { M.widget },
  text    = language.layout_f[language.get()],
}

-- ## LOGIC ##
local content = M.widget:get_children_by_id("content")[1]

M.update = function()
  content:set_text(language.layout_p[language.get()])
  M.tooltip:set_text(language.layout_f[language.get()])
end

M.switch = function()
  language.switch()
  M.update()
end

language.signals:connect_signal("language::switch", function()
  M.update()
end)

M.widget.buttons = {
  awful.button({}, 1, function()
    M.switch()
  end)
}

return M
