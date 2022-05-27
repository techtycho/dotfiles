local wibox = require("wibox")
local awful = require("awful")

local storage = wibox.widget {
	widget = awful.widget.watch('bash -c "df -h | grep /dev/sda2 | awk \'{print $3}\' | sed \'s/G/G   /\'"'),
}

local storage_clr = wibox.widget.background()
storage_clr:set_widget(storage)
storage_clr:set_fg("#dad536")

return storage_clr
