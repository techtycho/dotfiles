local gears = require("gears")

local M = {}

M.cmd      = "setxkbmap"
M.layout   = { "us", "ar" }
M.layout_p = { "EN", "AR" } -- Prettier names
M.layout_f = { "English", "Arabic" } -- Full names
M.current  = 1
M.signals  = gears.object() -- Object for emitting signals

M.get = function()
  return M.current
end

M.switch = function()
  M.current = M.current % #(M.layout) + 1
  os.execute(M.cmd .. " " .. M.layout[M.current])
  -- Signals
  M.signals:emit_signal("language::switch", M.current)
end

return M
