local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")

local M = {
  {
    {
      {
        id     = "text_role",
        widget = wibox.widget.textbox,
      },
      right  = beautiful.taglist_width or 9,
      left   = beautiful.taglist_width or 9,
      widget = wibox.container.margin,
    },
    id     = "background_role",
    widget = wibox.container.background,
  },
  id     = "underline",
  bottom = beautiful.taglist_underline_thickness or beautiful.underline_thickness or 3,
  widget = wibox.container.margin,

  create_callback = function(self, _, i)
    local t = awful.screen.focused().selected_tag
    local tags = awful.screen.focused().tags

    if #tags[i]:clients() > 0 then
      self:get_children_by_id("underline")[1].color = beautiful.taglist_underline_color_normal or beautiful.bg_focus or
        "#888"
    end

    if t.index == i then
      self:get_children_by_id("underline")[1].color = beautiful.taglist_underline_color_focus or beautiful.bg_focus or
        "#25a"
    elseif #tags[i]:clients() <= 0 then
      self:get_children_by_id("underline")[1].color = beautiful.bg_normal or "#000"
    end

    for _, v in ipairs(tags[i]:clients()) do
      if v.urgent then
        self:get_children_by_id("underline")[1].color = beautiful.taglist_underline_color_urgent or beautiful.bg_urgent
          or "#f00"
      end
    end
  end,

  update_callback = function(self, _, i)
    local t = awful.screen.focused().selected_tag
    local tags = awful.screen.focused().tags

    if #tags[i]:clients() > 0 then
      self:get_children_by_id("underline")[1].color = beautiful.taglist_underline_color_normal or beautiful.bg_focus or
        "#888"
    end

    if t.index == i then
      self:get_children_by_id("underline")[1].color = beautiful.taglist_underline_color_focus or beautiful.bg_focus or
        "#25a"
    elseif #tags[i]:clients() <= 0 then
      self:get_children_by_id("underline")[1].color = beautiful.bg_normal or "#000"
    end

    for _, v in ipairs(tags[i]:clients()) do
      if v.urgent then
        self:get_children_by_id("underline")[1].color = beautiful.taglist_underline_color_urgent or beautiful.bg_urgent
          or "#f00"
      end
    end
  end
}

return M
