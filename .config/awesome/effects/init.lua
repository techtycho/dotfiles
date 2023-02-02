local tagswitch = require("effects.tagswitch")

tag.connect_signal("property::selected", function(t)
  tagswitch.animate(tostring(t.index))
end)
