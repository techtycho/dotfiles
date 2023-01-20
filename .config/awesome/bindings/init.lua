local awful = require("awful")

local M = {}

M.modkey = "Mod4" -- Super key
M.mode = { ["global_"] = "global", ["local_"] = "local" }

M.keygroup = function(mode, groupName, keys)
  if mode == "global" then
    for _, k in ipairs(keys) do
      k.group = groupName
    end

    awful.keyboard.append_global_keybindings(keys)
  elseif mode == "local" then
    -- TODO local_ option
  end
end

return M
