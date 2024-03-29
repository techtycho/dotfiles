local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")

local client_stat = require("widgets.client_stat").widget
local volume      = require("widgets.volume").widget
local battery     = require("widgets.battery").widget
local language    = require("widgets.language").widget
local date        = require("widgets.date").widget
local clock       = require("widgets.clock").widget
local systray     = require("widgets.systray").widget

screen.connect_signal("request::desktop_decoration", function(s)
  s.mypromptbox = awful.widget.prompt()

  local taglist      = require("widgets.taglist").init(s)
  local layout       = require("widgets.layout").init(s)
  local client_title = require("widgets.client_title").init(s)

  -- Create the wibox
  s.mywibox = awful.wibar {
    position = "top",
    height   = beautiful.bar_height or 25,
    screen   = s,
    widget   = {
      layout = wibox.layout.align.horizontal,
      { -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        taglist,
        client_title,
      },
      wibox.widget.separator { opacity = 0 },
      { -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        client_stat,
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
