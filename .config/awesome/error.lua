local naughty = require("naughty")

naughty.connect_signal("request::display_error", function(message, startup)
  naughty.notification {
    urgency = "critical",
    title   = "Error" .. (startup and " (Startup)" or " (Runtime)"),
    message = message
  }
end)
