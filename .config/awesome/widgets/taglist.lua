local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")

local M = {}

M.init = function(s)
  awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])

  s.mytaglist = awful.widget.taglist {
    screen          = s,
    filter          = awful.widget.taglist.filter.all,
    buttons         = {
      awful.button({}, 1, function(t) t:view_only() end),

      awful.button({ modkey }, 1, function(t)
        if client.focus then
          client.focus:move_to_tag(t)
        end
      end),

      awful.button({}, 3, awful.tag.viewtoggle),

      awful.button({ modkey }, 3, function(t)
        if client.focus then
          client.focus:toggle_tag(t)
        end
      end),

      awful.button({}, 4, function(t) awful.tag.viewprev(t.screen) end),
      awful.button({}, 5, function(t) awful.tag.viewnext(t.screen) end),
    },
    widget_template = {
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
    },
  }
end

return M
