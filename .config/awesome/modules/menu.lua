local awful   = require("awful")
local menubar = require("menubar")
local apps    = require("apps")
local asset   = require("util.filesystem").asset

local M = {}

-- Menu items (temporary)
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
      asset("arch.png"),
    },
    { "Terminal", apps.terminal, asset("apps/alacritty.png") },
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

menubar.utils.terminal = apps.terminal

return M
