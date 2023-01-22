-- awesome_mode: api-level=4:screen=on

-- Make sure that installed LuaRocks packages are found
pcall(require, "luarocks.loader")

-- Standard AwesomeWM libraries
local beautiful = require("beautiful")
local ruled     = require("ruled")

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
require("modules.layout")
require("modules.wallpaper")
require("widgets")

-- Bindings
require("bindings.mouse")
require("bindings.key")

-- Rules
ruled.client.connect_signal("request::rules", function()
  require("rules")
end)

require("modules.notifications")
require("modules.misc")
require("autostart")
