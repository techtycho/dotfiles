local awful = require("awful")
local wibox = require("wibox")

screen.connect_signal("request::desktop_decoration", function(s)
  s.mypromptbox = awful.widget.prompt()

  s.mylayoutbox = wibox.widget {
    {
      {
        markup = "<b>[</b>",
        font   = "JetBrainsMono Nerd Font 12",
        widget = wibox.widget.textbox,
      },
      {
        awful.widget.layoutbox {
          screen  = s,
          buttons = {
            awful.button({}, 1, function() awful.layout.inc(1) end),
            awful.button({}, 3, function() awful.layout.inc(-1) end),
            awful.button({}, 4, function() awful.layout.inc(-1) end),
            awful.button({}, 5, function() awful.layout.inc(1) end),
          },
        },
        top    = 3,
        bottom = 2,
        widget = wibox.container.margin,
      },
      {
        markup = "<b>]</b>",
        font   = "JetBrainsMono Nerd Font 12",
        widget = wibox.widget.textbox,
      },
      layout = wibox.layout.fixed.horizontal,
    },
    left   = 3,
    right  = 3,
    bottom = 2,
    widget = wibox.container.margin,
  }

  require("widgets.taglist").init(s)

  -- Create the wibox
  s.mywibox = awful.wibar {
    position = "top",
    height   = 25,
    screen   = s,
    widget   = {
      layout = wibox.layout.align.horizontal,
      { -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        s.mytaglist,
        s.mypromptbox,
      },
      wibox.widget.separator { opacity = 0 },
      { -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        require("widgets.volume").widget,
        require("widgets.battery").widget,
        require("widgets.language").widget,
        require("widgets.date").widget,
        require("widgets.clock").widget,
        s.mylayoutbox,
        require("widgets.systray").widget,
      },
    }
  }
end)
