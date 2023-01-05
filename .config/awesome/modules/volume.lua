local gears = require("gears")
local awful = require("awful")

local M = {}

M.default_inc = 2

M.signals = gears.object()

M.cmd_volume_inc     = "amixer set Master " .. tostring(M.default_inc) .. "%+"
M.cmd_volume_dec     = "amixer set Master " .. tostring(M.default_inc) .. "%-"
M.cmd_volume_mute    = "amixer set Master toggle"
M.cmd_volume_speaker = "amixer set Speaker unmute"

M.emit_signals = function()
  M.signals:emit_signal("volume::update")
end

M.inc = function()
  awful.spawn(M.cmd_volume_inc)
  M.emit_signals()
end

M.dec = function()
  awful.spawn(M.cmd_volume_dec)
  M.emit_signals()
end

M.toggle = function()
  awful.spawn(M.cmd_volume_mute)
  awful.spawn(M.cmd_volume_speaker)
  M.emit_signals()
end

return M
