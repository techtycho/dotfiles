local awful = require("awful")

local bind = require("bindings")
local modkey = bind.modkey

bind.keygroup(bind.mode.global, "layout", {
  -- Increase Master Width Factor | Super + l
  awful.key({ modkey }, "l",
    function()
      awful.tag.incmwfact(0.05)
    end,
    { description = "Increase master width factor" }),

  -- Decrease Master Width Factor | Super + h
  awful.key({ modkey, }, "h",
    function()
      awful.tag.incmwfact(-0.05)
    end,
    { description = "Decrease master width factor" }),

  -- Increase Number Of Master Clients | Super + Shift + h
  awful.key({ modkey, "Shift" }, "h",
    function()
      awful.tag.incnmaster(1, nil, true)
    end,
    { description = "Increase number of master clients" }),

  -- Decrease Number Of Master Clients | Super + Shift + l
  awful.key({ modkey, "Shift" }, "l",
    function()
      awful.tag.incnmaster(-1, nil, true)
    end,
    { description = "Decrease number of master clients" }),


  -- Increase Number Of Columns | Super + Ctrl + h
  awful.key({ modkey, "Control" }, "h",
    function()
      awful.tag.incncol(1, nil, true)
    end,
    { description = "Increase number of columns" }),

  -- Decrease Number Of Columns | Super + Ctrl + l
  awful.key({ modkey, "Control" }, "l",
    function()
      awful.tag.incncol(-1, nil, true)
    end,
    { description = "Decrease number of columns" }),

  -- Next Layout | Super + Space
  awful.key({ modkey, }, "space",
    function()
      awful.layout.inc(1)
    end,
    { description = "Next Layout" }),

  -- Previous Layout | Super + Shift + Space
  awful.key({ modkey, "Shift" }, "space",
    function()
      awful.layout.inc(-1)
    end,
    { description = "Select previous" }),
})

bind.keygroup(bind.mode.global, "client", {
  -- Swap With Next Client (by index) | Super + Shift + j
  awful.key({ modkey, "Shift" }, "j",
    function()
      awful.client.swap.byidx(1)
    end,
    { description = "Swap with next client (by index)" }),

  -- Swap With Previous Client (by index) | Super + Shift + k
  awful.key({ modkey, "Shift" }, "k",
    function()
      awful.client.swap.byidx(-1)
    end,
    { description = "Swap with previous client (by index)" }),

  -- Jump To Urgent Client | Super + u
  awful.key({ modkey, }, "u",
    awful.client.urgent.jumpto,
    { description = "Jump to urgent client" }),
})
