local awful = require("awful")

local bind = require("bindings")
local modkey = bind.modkey
local mouse = awful.button.names

client.connect_signal("request::default_mousebindings", function()
  awful.mouse.append_client_mousebindings({
    -- Show Window | Left Click
    awful.button({}, mouse.LEFT, function(c)
      c:activate { context = "mouse_click" }
    end),

    -- Move Window | Super + Left Click
    awful.button({ modkey }, mouse.LEFT, function(c)
      c:activate { context = "mouse_click", action = "mouse_move" }
    end),

    -- Resize Window | Super + Right Click
    awful.button({ modkey }, mouse.RIGHT, function(c)
      c:activate { context = "mouse_click", action = "mouse_resize" }
    end),
  })
end)
