local wibox = require("wibox")
local awful = require("awful")

local current_layout = wibox.widget {
	widget = wibox.widget.textbox()
}

local current_tag

screen[1]:connect_signal("tag::history::update", function()
	current_tag = awful.tag.selected(1)
	current_layout.text = " [" .. awful.layout.getname(awful.layout.layouts[awful.layout.get_tag_layout_index(current_tag)]) .. "] "

	current_tag:connect_signal("property::layout", function()
		current_layout.text = " [" .. awful.layout.getname(awful.layout.layouts[awful.layout.get_tag_layout_index(current_tag)]) .. "] "
	end)
end)

current_layout:connect_signal("button::press", function() 
	awful.layout.inc(1)
end)

local current_layout_clr = wibox.widget.background()
current_layout_clr:set_widget(current_layout)

current_layout_clr:set_fg("#9e6b61")

return current_layout_clr
