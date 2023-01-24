local gears = require("gears")
local awful = require("awful")

local M = {}

M.step = 2
M.signals = gears.object() -- Object for emitting signals

M.cmd_volume_inc     = "amixer set Master " .. tostring(M.step) .. "%+"
M.cmd_volume_dec     = "amixer set Master " .. tostring(M.step) .. "%-"
M.cmd_volume_mute    = "amixer set Master toggle"
M.cmd_volume_speaker = "amixer set Speaker unmute"

M.inc = function()
  awful.spawn(M.cmd_volume_inc)
  M.signals:emit_signal("volume::update")
end

M.dec = function()
  awful.spawn(M.cmd_volume_dec)
  M.signals:emit_signal("volume::update")
end

M.toggle = function()
  awful.spawn(M.cmd_volume_mute)
  awful.spawn(M.cmd_volume_speaker)
  M.signals:emit_signal("volume::update")
end

return M
