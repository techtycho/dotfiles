local wibox = require("wibox")
local awful = require("awful")

local volume = wibox.widget {
	widget = awful.widget.watch('bash -c "amixer sget Master | grep Mono: | awk \'{print $4}\' | sed \'s/^.//;s/.$//\' | sed \'s/%/%  /\'"')
}

local volume_clr = wibox.widget.background()
volume_clr:set_widget(volume)
volume_clr:set_fg("#52a2a8")

return volume_clr
