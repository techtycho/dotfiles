local awful = require("awful")

local M = {}

M.modkey = "Mod4" -- Super key
M.mode = { ["global_"] = "global", ["client_"] = "client" }

M.keygroup = function(mode, groupName, keys)
  for _, k in ipairs(keys) do
    k.group = groupName
  end

  if mode == "global" then
    awful.keyboard.append_global_keybindings(keys)
  elseif mode == "client" then
    awful.keyboard.append_client_keybindings(keys)
  end
end

return M
