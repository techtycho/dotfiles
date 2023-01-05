local awful = require("awful")

screen.connect_signal("request::wallpaper", function()
  awful.spawn("nitrogen --restore")
end)
