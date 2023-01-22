local awful = require("awful")

local bind = require("bindings")
local modkey = bind.modkey

bind.keygroup(bind.mode.global_, "client", {
  -- Focus Next By Index | Super + j
  awful.key({ modkey, }, "j",
    function()
      awful.client.focus.byidx(1)
    end,
    { description = "Focus next by index" }
  ),

  -- Focus Previous By Index | Super + k
  awful.key({ modkey, }, "k",
    function()
      awful.client.focus.byidx(-1)
    end,
    { description = "Focus previous by index" }
  ),

  -- Go Back | Super + Tab
  awful.key({ modkey, }, "Tab",
    function()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end,
    { description = "Go back" }),

  -- Restore Minimized | Super + Ctrl + n
  awful.key({ modkey, "Control" }, "n",
    function()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        c:activate { raise = true, context = "key.unminimize" }
      end
    end,
    { description = "Restore minimized" }),
})

-- Screen-related Keybindings
bind.keygroup(bind.mode.global_, "screen", {
  -- Focus Next Screen | Super + Ctrl + j
  awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end,
    { description = "Focus the next screen" }),

  -- Focus Previous Screen | Super + Ctrl + k
  awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end,
    { description = "Focus the previous screen" }),
})
