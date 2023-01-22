local awful = require("awful")

local mouse = awful.button.names

awful.mouse.append_global_mousebindings({
  -- Scroll to view next and previous tags
  awful.button({}, mouse.SCROLL_UP, awful.tag.viewprev),
  awful.button({}, mouse.SCROLL_DOWN, awful.tag.viewnext),
})
