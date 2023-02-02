local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")

-- DPI
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local fade = require("animations.fade")

local M = wibox {
  visible = false,
  opacity = 0,
  bg      = beautiful.tagswitch_bg or beautiful.bg_normal or "#000",
  fg      = beautiful.tagswitch_fg or beautiful.fg_normal or "#fff",
  ontop   = true,
  height  = beautiful.tagswitch_height or dpi(90),
  width   = beautiful.tagswitch_width or dpi(180),
}

M:setup {
  {
    id     = "text",
    markup = "<b>tag</b>",
    font   = beautiful.tagswitch_font or beautiful.font or "sans 37",
    widget = wibox.widget.textbox,
  },
  valign = "center",
  halign = "center",
  layout = wibox.container.place,
}

awful.placement.centered(M, { parent = awful.screen.focused() })

M.changeText = function(text)
  M:get_children_by_id("text")[1]:set_markup("<b>" .. text .. "</b>")
end

M.animate = function(text)
  M.changeText(text)
  fade(M, beautiful.tagswitch_speed or 200, beautiful.tagswitch_delay or 0.25)
end

return M
