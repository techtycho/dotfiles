local ruled = require("ruled")

ruled.client.append_rule {
  id         = "floating",
  rule_any   = {
    instance = {
      "copyq",
      "pinentry"
    },
    class    = {
      "Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv",
      "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer"
    },
    name     = {
      "Event Tester",
    },
    role     = {
      "AlarmWindow",
      "ConfigManager",
      "pop-up",
      "About",
    }
  },
  properties = { floating = true }
}
