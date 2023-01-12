local awful = require("awful")
local menu  = require("modules.menu")

awful.mouse.append_global_mousebindings({
  -- Show main menu on right click
  awful.button({}, 3, function()
    menu.menu:toggle()
  end),

  -- Scroll to view next and previous tags
  awful.button({}, 4, awful.tag.viewprev),
  awful.button({}, 5, awful.tag.viewnext),
})
