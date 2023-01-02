local awful     = require("awful")
local beautiful = require("beautiful")
local menubar   = require("menubar")
local apps      = require("apps")
local asset     = require("util.filesystem").asset

local M = {}

-- Temporary
M.menu = awful.menu({
  items = {
    { "Awesome",
      {
        { "Restart", awesome.restart },
        { "Quit",
          function()
            awesome.quit()
          end
        },
      },
      asset("arch.png")
    },
    { "Terminal", apps.terminal, asset("terminal.svg") },
    { "Applications",
      {
        { "Browser", apps.browser, asset("apps/brave.png") },
        { "Emacs", "emacs", asset("apps/emacs.png") },
        { "VSCodium", "vscodium", asset("apps/vscodium.png") },
        { "Neovim", apps.terminal .. " -e nvim", asset("apps/nvim.png") },
        { "VIRT Manager", "virt-manager", asset("apps/virt.png") },
      },
    }
  },
})

M.launcher = awful.widget.launcher({
  image = beautiful.awesome_icon,
  menu = M.menu,
})

menubar.utils.terminal = apps.terminal

return M
