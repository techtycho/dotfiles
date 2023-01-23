-- awesome_mode: api-level=4:screen=on

pcall(require, "luarocks.loader")

-- Standard AwesomeWM libraries
local beautiful = require("beautiful")
local ruled     = require("ruled")

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
require("modules.notifications")
require("modules.misc")
-- Widgets
require("widgets")

-- ## BINDINGS ##
require("bindings.mouse")
require("bindings.key")

-- ## RULES ##
ruled.client.connect_signal("request::rules", function()
  require("rules")
end)

-- ## AUTOSTART ##
require("autostart")
