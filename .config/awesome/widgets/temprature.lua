local wibox = require("wibox")
local awful = require("awful")

local temprature = wibox.widget {
	widget = awful.widget.watch('bash -c "sensors | grep CPU | awk \'{print $2}\' | sed \'s/C/C   /\'"', 15),
}

local temprature_clr = wibox.widget.background()
temprature_clr:set_widget(temprature)
temprature_clr:set_fg("#e5a75b")

return temprature_clr
