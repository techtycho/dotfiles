local awful = require("awful")

awful.mouse.append_global_mousebindings({
  -- Scroll to view next and previous tags
  awful.button({}, 4, awful.tag.viewprev),
  awful.button({}, 5, awful.tag.viewnext),
})
