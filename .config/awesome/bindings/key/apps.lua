local awful = require("awful")
local apps  = require("apps")

local bind = require("bindings")
local modkey = bind.modkey

-- App Keybindings
bind.keygroup(bind.mode.global, "apps", {
  -- Open Browser | Super + b (followed by KEY)
  --    b -> Open Browser (default)
  --    s -> Open Search
  --    g -> Open Online Git Service
  --    y -> Open Youtube
  --    w -> Open Wikipedia
  --    t -> Open Trello
  --    r -> Open Reddit
  awful.key({ modkey }, "b", function()
    local grabber
    grabber = awful.keygrabber.run(
      function(_, key, event)
        if event == "release" then return end

        if key == "b" then awful.spawn(apps.browser) -- Default
        elseif key == "s" then awful.spawn(apps.browser .. " " .. apps.search)
        elseif key == "g" then awful.spawn(apps.browser .. " " .. apps.git_serv)
        elseif key == "y" then awful.spawn(apps.browser .. " " .. "youtube.com")
        elseif key == "w" then awful.spawn(apps.browser .. " " .. "wikipedia.com")
        elseif key == "t" then awful.spawn(apps.browser .. " " .. "trello.com")
        elseif key == "r" then awful.spawn(apps.browser .. " " .. "reddit.com")
        else awful.keygrabber.stop(grabber) end
      end
    )
  end),

  -- Open File Manager | Super + d (followed by KEY)
  --    d -> Open File Manager (default)
  --    b -> Open Books Directory
  --    w -> Open Wallpaper Manager
  awful.key({ modkey }, "d", function()
    local grabber
    grabber = awful.keygrabber.run(
      function(_, key, event)
        if event == "release" then return end

        if key == "d" then awful.spawn(apps.files) -- Default
        elseif key == "b" then awful.spawn(apps.files .. " Documents/books")
        elseif key == "w" then awful.spawn("nitrogen")
        else awful.keygrabber.stop(grabber) end
      end
    )
  end),

  -- Open Editor | Super + e
  --    e -> Open Editor
  --    d -> Open Dev Editor
  --    t -> Open Terminal Editor
  awful.key({ modkey }, "e", function()
    local grabber
    grabber = awful.keygrabber.run(
      function(_, key, event)
        if event == "release" then return end

        if key == "e" then awful.spawn(apps.editor)
        elseif key == "d" then awful.spawn(apps.editor_dev)
        elseif key == "t" then awful.spawn(apps.terminal .. " -e " .. apps.editor_term)
        else awful.keygrabber.stop(grabber) end
      end
    )
  end),
})
