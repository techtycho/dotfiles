local awful    = require("awful")
local menu     = require("modules.menu")
local apps     = require("apps")
local language = require("modules.language")
local volume   = require("modules.volume")

local modkey = require("bindings").modkey

awful.keyboard.append_global_keybindings({
  awful.key({ modkey, }, "w",
    function()
      menu.menu:show()
    end,
    { description = "Show main menu", group = "awesome" }),

  awful.key({ modkey, "Control" }, "r", awesome.restart,
    { description = "Reload AwesomeWM", group = "awesome" }),

  awful.key({ modkey, "Shift" }, "q", awesome.quit,
    { description = "Quit AwesomeWM", group = "awesome" }),

  awful.key({ modkey, }, "Return", function() awful.spawn(terminal) end,
    { description = "Open a terminal", group = "launcher" }),

  awful.key({ modkey }, "p", function() awful.spawn(apps.launcher) end,
    { description = "Show the menubar", group = "launcher" }),

  -- Audio Control
  awful.key({}, "XF86AudioRaiseVolume", volume.inc),
  awful.key({}, "XF86AudioLowerVolume", volume.dec),
  awful.key({}, "XF86AudioMute", volume.toggle),

  -- Keyboard Layout Control
  awful.key({ modkey }, "Shift_R", function() language.switch() end),
})
