local awful = require("awful")

tag.connect_signal("request::default_layouts", function()
  -- ! Order matters
  awful.layout.append_default_layouts({
    awful.layout.suit.tile, -- Default on all tags
    awful.layout.suit.floating,
    awful.layout.suit.magnifier,
  })
end)
