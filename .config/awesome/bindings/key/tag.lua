local awful = require("awful")

local bind = require("bindings")
local modkey = bind.modkey

-- Tag-related Keybindings
bind.keygroup(bind.mode.global_, "tag", {
  -- View Previous Tag | Super + Left Arrow
  awful.key({ modkey, }, "Left", awful.tag.viewprev,
    { description = "View Previous Tag" }),

  -- View Next Tag | Super + Right Arrow
  awful.key({ modkey, }, "Right", awful.tag.viewnext,
    { description = "View next tag" }),

  -- Go Back To Last Tag | Super + Escape
  awful.key({ modkey, }, "Escape", awful.tag.history.restore,
    { description = "Go back to last tag" }),
})

bind.keygroup(bind.mode.global_, "tag", {
  -- View Tag | Super + Tag
  awful.key {
    modifiers   = { modkey },
    keygroup    = "numrow",
    description = "View tag",
    on_press    = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]

      if tag then
        tag:view_only()
      end
    end,
  },

  -- Toggle Tag | Super + Ctrl + Tag
  awful.key {
    modifiers   = { modkey, "Control" },
    keygroup    = "numrow",
    description = "Toggle tag",
    on_press    = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]

      if tag then
        awful.tag.viewtoggle(tag)
      end
    end,
  },

  -- Move Focused Client To Tag | Super + Shift + Tag
  awful.key {
    modifiers   = { modkey, "Shift" },
    keygroup    = "numrow",
    description = "Move focused client to tag",
    on_press    = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        local c = client.focus

        if tag then
          c:move_to_tag(tag)
          c.urgent = true -- Make the moved client urgent
        end
      end
    end,
  },

  -- Toggle Focused Client On Tag | Super + Shift + Ctrl + Tag
  awful.key {
    modifiers   = { modkey, "Control", "Shift" },
    keygroup    = "numrow",
    description = "Toggle focused client on tag",
    on_press    = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]

        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end,
  },

  -- Select Layout Directly | Super + Tag (Numpad)
  awful.key {
    modifiers   = { modkey },
    keygroup    = "numpad",
    description = "Select layout directly",
    on_press    = function(index)
      local t = awful.screen.focused().selected_tag

      if t then
        t.layout = t.layouts[index] or t.layout
      end
    end,
  }
})
