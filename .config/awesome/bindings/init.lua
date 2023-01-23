local awful = require("awful")

local M = {}

M.modkey = "Mod4" -- Super key
M.mode = { global = 0, client = 1 }

M.keygroup = function(mode, groupName, keys)
  for _, k in ipairs(keys) do
    k.group = groupName
  end

  if mode == 0 then
    awful.keyboard.append_global_keybindings(keys)
  elseif mode == 1 then
    awful.keyboard.append_client_keybindings(keys)
  end
end

return M
