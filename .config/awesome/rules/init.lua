local awful = require("awful")
local ruled = require("ruled")

-- All clients will match this rule.
ruled.client.append_rule {
  id         = "global",
  rule       = {},
  properties = {
    focus     = awful.client.focus.filter,
    raise     = true,
    screen    = awful.screen.preferred,
    placement = awful.placement.no_overlap + awful.placement.no_offscreen
  }
}

require("rules.floating")
