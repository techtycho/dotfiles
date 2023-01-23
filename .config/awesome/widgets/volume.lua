local awful = require("awful")
local wibox = require("wibox")

local volume = require("modules.volume")

local M = {}

M.cmd      = "amixer sget Master | grep Mono: | awk '{print $4}' | sed 's/^.//;s/.$//'"
M.cmd_mute = "amixer sget Master | grep Mono: | awk '{print $6}' | sed 's/^.//;s/.$//'"

M.widget = wibox.widget {
  {
    {
      {
        {
          id = "icon",
          text = "墳 ",
          widget = wibox.widget.textbox,
        },
        {
          id     = "volume",
          text   = "...",
          widget = wibox.widget.textbox,
        },
        layout = wibox.layout.fixed.horizontal,
      },
      id     = "underline",
      bottom = 2,
      color  = "#61afef",
      widget = wibox.container.margin,
    },
    right  = 6,
    left   = 6,
    widget = wibox.container.margin,
  },
  id     = "fg",
  fg     = "#61afef",
  widget = wibox.container.background,
}

M.update = function()
  awful.spawn.easy_async_with_shell(M.cmd, function(stdout)
    M.widget:get_children_by_id("volume")[1]:set_text(stdout)
  end)

  awful.spawn.easy_async_with_shell(M.cmd_mute, function(stdout)
    -- I'm not good at sed and regex, if you have any idea why the command produces
    -- a newline after the word 'off' or 'on', tell me via issues or PR.
    if stdout == "off\n" then
      M.widget:get_children_by_id("icon")[1]:set_text("婢 ")
      M.widget:get_children_by_id("fg")[1]:set_fg("#fff4")
      M.widget:get_children_by_id("underline")[1]:set_color("#fff4")
      return
    end

    M.widget:get_children_by_id("icon")[1]:set_text("墳 ")
    M.widget:get_children_by_id("fg")[1]:set_fg("#61afef")
    M.widget:get_children_by_id("underline")[1]:set_color("#61afef")
  end)
end

volume.signals:connect_signal("volume::update", M.update)
M.update()

return M
