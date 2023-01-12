local awful = require("awful")
local wibox = require("wibox")

local volume   = require("widgets.volume").widget
local battery  = require("widgets.battery").widget
local language = require("widgets.language").widget
local date     = require("widgets.date").widget
local clock    = require("widgets.clock").widget
local systray  = require("widgets.systray").widget

screen.connect_signal("request::desktop_decoration", function(s)
  s.mypromptbox = awful.widget.prompt()

  local taglist = require("widgets.taglist").init(s)
  local layout  = require("widgets.layout").init(s)

  -- Create the wibox
  s.mywibox = awful.wibar {
    position = "top",
    height   = 25,
    screen   = s,
    widget   = {
      layout = wibox.layout.align.horizontal,
      { -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        taglist,
      },
      wibox.widget.separator { opacity = 0 },
      { -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        volume,
        battery,
        language,
        date,
        clock,
        layout,
        systray,
      },
    }
  }
end)
