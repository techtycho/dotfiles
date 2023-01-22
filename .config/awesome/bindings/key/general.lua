local awful    = require("awful")
local apps     = require("apps")
local language = require("modules.language")
local volume   = require("modules.volume")

local bind = require("bindings")
local modkey = bind.modkey

-- AwesomeWM Process
bind.keygroup(bind.mode.global_, "awesomewm", {
  -- Quit AwesomeWM | Super + Shift + q
  awful.key({ modkey, "Shift" }, "q",
    awesome.quit,
    { description = "Quit AwesomeWM" }),

  -- Reload AwesomeWM | Super + Ctrl + r
  awful.key({ modkey, "Control" }, "r",
    awesome.restart,
    { description = "Reload AwesomeWM" }),
})

-- Essential Applications and Launchers
bind.keygroup(bind.mode.global_, "launcher", {
  -- Open a Terminal | Super + Return
  awful.key({ modkey, }, "Return",
    function()
      awful.spawn(apps.terminal)
    end,
    { description = "Open a Terminal" }),

  -- Open App Launcher (dmenu) | Super + p
  awful.key({ modkey }, "p",
    function()
      awful.spawn(apps.launcher)
    end,
    { description = "Open App Launcher" }),
})

-- Control Keybindings (eg. volume & language)
bind.keygroup(bind.mode.global_, "control", {
  -- Switch Language | Super + Right Shift
  awful.key({ modkey }, "Shift_R",
    function()
      language.switch()
    end,
    { description = "Switch language" }),

  -- Audio Control
  awful.key({}, "XF86AudioRaiseVolume", volume.inc,
    { description = "Raise volume" }),
  awful.key({}, "XF86AudioLowerVolume", volume.dec,
    { description = "Lower volume" }),
  awful.key({}, "XF86AudioMute", volume.toggle,
    { description = "Mute/Unmute volume" }),
})
