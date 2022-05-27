local wibox = require("wibox")
local awful = require("awful")
local fa_icons = require("widgets.fa-icons")

local battery = wibox.widget {
	widget = awful.widget.watch('bash -c "echo $(~/Scripts/battery.sh)% | sed \'s/%/%  /\'"', 15),
}

local battery_clr = wibox.widget.background()
battery_clr:set_widget(battery)
battery_clr:set_fg("#9c9d9e")

return battery_clr
