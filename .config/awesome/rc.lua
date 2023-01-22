-- awesome_mode: api-level=4:screen=on

-- Make sure that installed LuaRocks packages are found
pcall(require, "luarocks.loader")

-- Standard AwesomeWM libraries
local gears     = require("gears")
local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local naughty   = require("naughty")
local ruled     = require("ruled")

-- Other libraries
local hotkeys_popup = require("awful.hotkeys_popup")

require("awful.hotkeys_popup.keys")
require("awful.autofocus")

-- Error Handling
require("error")

-- ## VARIABLES ## --
local filesystem = require("util.filesystem")

_G.config_dir = filesystem.dir
_G.subdirs = {
  themes = _G.config_dir .. "themes/",
  assets = _G.config_dir .. "assets/",
}

_G.theme = "default"
beautiful.init(_G.subdirs.themes .. _G.theme .. "/theme.lua");

-- ## MODULES ## --
local apps = require("apps")

require("modules.layout")
require("modules.wallpaper")
require("widgets")

-- Temporary
terminal = apps.terminal
modkey = require("bindings").modkey

-- Bindings
require("bindings.mouse")
require("bindings.key")

-- {{{ Rules
-- Rules to apply to new clients.
ruled.client.connect_signal("request::rules", function()
  -- All clients will match this rule.
  ruled.client.append_rule {
    id         = "global",
    rule       = {},
    properties = {
      focus     = awful.client.focus.filter,
      raise     = true,
      screen    = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen
    }
  }

  -- Floating clients.
  ruled.client.append_rule {
    id         = "floating",
    rule_any   = {
      instance = { "copyq", "pinentry" },
      class    = {
        "Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv",
        "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer"
      },
      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name     = {
        "Event Tester", -- xev.
      },
      role     = {
        "AlarmWindow", -- Thunderbird's calendar.
        "ConfigManager", -- Thunderbird's about:config.
        "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
      }
    },
    properties = { floating = true }
  }

end)

-- {{{ Notifications

ruled.notification.connect_signal("request::rules", function()
  -- All notifications will match this rule.
  ruled.notification.append_rule {
    rule       = {},
    properties = {
      screen           = awful.screen.preferred,
      implicit_timeout = 5,
    }
  }
end)

naughty.connect_signal("request::display", function(n)
  naughty.layout.box { notification = n }
end)

-- }}}

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:activate { context = "mouse_enter", raise = false }
end)

require("autostart")
