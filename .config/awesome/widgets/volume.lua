local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")

local volume = require("modules.volume")

local M = {}

M.cmd      = "amixer sget Master | grep Mono: | awk '{print $4}' | sed 's/^.//;s/.$//'"
M.cmd_mute = "amixer sget Master | grep Mono: | awk '{print $6}' | sed 's/^.//;s/.$//'"

-- ## TEMPLATE ##
M.widget = wibox.widget {
  {
    {
      {
        {
          id = "icon",
          text = beautiful.widget_volume_icon or "",
          widget = wibox.widget.textbox,
        },
        {
          id     = "text",
          widget = wibox.widget.textbox,
        },
        layout = wibox.layout.fixed.horizontal,
      },
      id     = "underline",
      bottom = beautiful.underline_thickness or 2,
      color  = beautiful.widget_volume_color or beautiful.fg_color or "#fff",
      widget = wibox.container.margin,
    },
    right  = beautiful.widget_spacing or 6,
    left   = beautiful.widget_spacing or 6,
    widget = wibox.container.margin,
  },
  fg     = beautiful.widget_volume_color or beautiful.fg_color or "#fff",
  widget = wibox.container.background,
}

-- ## EFFECTS ##
M.widget:connect_signal("mouse::enter", function()
  M.widget:set_bg(beautiful.hover_bg or "#fff1")
end)

M.widget:connect_signal("mouse::leave", function()
  M.widget:set_bg("#fff0")
end)

-- ## LOGIC ##
M.widget.buttons = {
  awful.button({}, 1, function()
    volume.toggle()
  end)
}

M.update = function()
  awful.spawn.easy_async_with_shell(M.cmd, function(stdout)
    M.widget:get_children_by_id("text")[1]:set_text(stdout)
  end)

  awful.spawn.easy_async_with_shell(M.cmd_mute, function(stdout)
    -- I'm not good at sed and regex, if you have any idea why the command produces
    -- a newline after the word 'off' or 'on', tell me via issues or PR.
    if stdout == "off\n" then
      M.widget:set_fg(beautiful.widget_volume_color_muted or beautiful.fg_color or "#fff4")
      M.widget:get_children_by_id("icon")[1]:set_text(beautiful.widget_volume_icon_muted or "")
      M.widget:get_children_by_id("underline")[1]:set_color(beautiful.widget_volume_color_muted or beautiful.fg_color or
        "#fff4")

      return
    end

    M.widget:set_fg(beautiful.widget_volume_color or beautiful.fg_color or "#fff")
    M.widget:get_children_by_id("icon")[1]:set_text(beautiful.widget_volume_icon or "")
    M.widget:get_children_by_id("underline")[1]:set_color(beautiful.widget_volume_color or beautiful.fg_color or "#fff")
  end)
end

volume.signals:connect_signal("volume::update", M.update)
M.update()

return M
