local wibox = require("wibox")

-- FontAwesome
local function make_fa_icon(code)
  return wibox.widget{
    font = "fa5-solid-900 16",
    markup = ' <span color="#fff">' .. code .. '</span> ',
    align  = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
  }
end

return make_fa_icon
