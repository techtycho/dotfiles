local gears = require("gears")

local M = {}

M.cmd      = "setxkbmap"
M.layout   = { "us", "ar" }
M.layout_f = { "EN", "AR" } -- User friendly names
M.current  = 1
M.signals  = gears.object() -- Object for emitting signals

M.get = function()
  return M.layout_f[M.current]
end

M.emit_signals = function()
  M.signals:emit_signal("language::switch", M.current) -- On update
end

M.switch = function()
  M.current = M.current % #(M.layout) + 1
  os.execute(M.cmd .. " " .. M.layout[M.current])
  -- Signals
  M.emit_signals()
end

return M
