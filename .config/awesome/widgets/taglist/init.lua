local awful = require("awful")

local M = {}

M.init = function(s)
  awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])

  return awful.widget.taglist {
    screen          = s,
    filter          = awful.widget.taglist.filter.all,
    buttons         = require("widgets.taglist.buttons"),
    widget_template = require("widgets.taglist.template"),
  }
end

return M
