local awful = require("awful")

local autostart = {
  "picom --experimental-backends",
  "lxsession",
}

for _, v in ipairs(autostart) do
  awful.spawn(v)
end
