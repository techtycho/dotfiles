local awful = require("awful")

local bind = require("bindings")
local modkey = bind.modkey

client.connect_signal("request::default_keybindings", function()
  bind.keygroup(bind.mode.client_, "client", {
    awful.key({ modkey, }, "f",
      function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
      end,
      { description = "Toggle fullscreen" }),

    awful.key({ modkey, "Shift" }, "c", function(c) c:kill() end,
      { description = "Close" }),

    awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle,
      { description = "Toggle floating" }),

    awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end,
      { description = "Move to master" }),

    awful.key({ modkey, }, "o", function(c) c:move_to_screen() end,
      { description = "Move to screen" }),

    awful.key({ modkey, }, "t", function(c) c.ontop = not c.ontop end,
      { description = "Toggle keep on top" }),

    awful.key({ modkey, }, "n",
      function(c)
        -- The client currently has the input focus, so it cannot be
        -- minimized, since minimized clients can't have the focus.
        c.minimized = true
      end,
      { description = "Minimize" }),

    awful.key({ modkey, }, "m",
      function(c)
        c.maximized = not c.maximized
        c:raise()
      end,
      { description = "(Un)Maximize" }),

    awful.key({ modkey, "Control" }, "m",
      function(c)
        c.maximized_vertical = not c.maximized_vertical
        c:raise()
      end,
      { description = "(Un)Maximize vertically" }),

    awful.key({ modkey, "Shift" }, "m",
      function(c)
        c.maximized_horizontal = not c.maximized_horizontal
        c:raise()
      end,
      { description = "(Un)Maximize horizontally" }),
  })
end)
