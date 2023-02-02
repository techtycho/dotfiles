local gears      = require("gears")
local animations = require("animations")

local timeout = gears.timer.start_new

local function hide(w)
  w.visible = false
  w.opacity = 0
end

local function show(w)
  w.visible = true
  w.opacity = 1
end

return function(widget, speed, delay)
  if animations.busy then
    for _, v in ipairs(animations.timers) do
      v:stop()
    end
  end

  show(widget)

  table.insert(animations.timers, timeout(delay, function()
    animations.busy = true

    -- The maximum number of frames
    local max = 50

    for f = 1, max do
      table.insert(animations.timers, timeout((f / speed), function()
        f = f + 1

        -- Decrease the opacity to make fading effect
        widget.opacity = widget.opacity - 0.02

        -- This runs when the animation is finished
        if f == max then
          animations.busy = false
          hide(widget)
        end
      end))
    end
  end))
end
