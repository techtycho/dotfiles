local awful = require("awful")
local wibox = require("wibox")

local M = {
  {
    {
      {
        id     = "text_role",
        widget = wibox.widget.textbox,
      },
      right  = 9,
      left   = 9,
      widget = wibox.container.margin,
    },
    id     = "background_role",
    widget = wibox.container.background,
  },
  id     = "underline",
  bottom = 3,
  color  = "#282c34",
  widget = wibox.container.margin,

  create_callback = function(self, _, i)
    local t = awful.screen.focused().selected_tag
    local tags = awful.screen.focused().tags

    if #tags[i]:clients() > 0 then
      self:get_children_by_id("underline")[1].color = "#888"
    end

    if t.index == i then
      self:get_children_by_id("underline")[1].color = "#61afef"
    elseif #tags[i]:clients() <= 0 then
      self:get_children_by_id("underline")[1].color = "#282c34"
    end
  end,

  update_callback = function(self, _, i)
    local t = awful.screen.focused().selected_tag
    local tags = awful.screen.focused().tags

    if #tags[i]:clients() > 0 then
      self:get_children_by_id("underline")[1].color = "#888"
    end

    if t.index == i then
      self:get_children_by_id("underline")[1].color = "#61afef"
    elseif #tags[i]:clients() <= 0 then
      self:get_children_by_id("underline")[1].color = "#282c34"
    end
  end
}

return M
