local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local gears     = require("gears")

local M = {}
local signals = gears.object() -- Object for emitting signals

-- ## TEMPLATE ##
M.widget = wibox.widget {
  {
    {
      {
        {
          text = beautiful.widget_client_stat_icon or "",
          widget = wibox.widget.textbox,
        },
        {
          id     = "text",
          widget = wibox.widget.textbox,
        },
        layout = wibox.layout.fixed.horizontal,
      },
      bottom = beautiful.underline_thickness or 2,
      color  = beautiful.widget_client_stat_color or beautiful.fg_color or "#fff",
      widget = wibox.container.margin,
    },
    right  = beautiful.widget_spacing or 6,
    left   = beautiful.widget_spacing or 6,
    widget = wibox.container.margin,
  },
  fg                 = beautiful.widget_client_stat_color or beautiful.fg_color or "#fff",
  shape_border_color = "#000", -- THIS DOESN'T AFFECT THE APPEARANCE, pretend it's not there, but don't remove it.
  widget             = wibox.container.background,
}

-- ## EFFECTS ##
M.widget:connect_signal("mouse::enter", function()
  M.widget:set_bg(beautiful.hover_bg or "#fff1")
end)

M.widget:connect_signal("mouse::leave", function()
  M.widget:set_bg("#fff0")
end)

-- ## POPUP ##
local popup_widget = wibox.widget {
  {
    {
      {
        {
          id     = "popup_total_stat",
          markup = "<b>0</b>",
          font   = "Liberation Sans 25",
          halign = "center",
          widget = wibox.widget.textbox,
        },
        {
          text   = "TOTAL",
          halign = "center",
          font   = "JetBrainsMono Nerd Font 7",
          widget = wibox.widget.textbox,
        },
        layout = wibox.layout.fixed.vertical,
      },
      {
        {
          id     = "popup_minimized_stat",
          markup = "<b>0</b>",
          font   = "Liberation Sans 25",
          halign = "center",
          widget = wibox.widget.textbox,
        },
        {
          text   = "MINIMIZED",
          halign = "center",
          font   = "JetBrainsMono Nerd Font 7",
          widget = wibox.widget.textbox,
        },
        layout = wibox.layout.fixed.vertical,
      },
      {
        {
          id     = "popup_urgent_stat",
          markup = "<b>0</b>",
          font   = "Liberation Sans 25",
          halign = "center",
          widget = wibox.widget.textbox,
        },
        {
          text   = "URGENT",
          halign = "center",
          font   = "JetBrainsMono Nerd Font 7",
          widget = wibox.widget.textbox,
        },
        layout = wibox.layout.fixed.vertical,
      },
      spacing = 5,
      forced_width = 250,
      layout = wibox.layout.flex.horizontal,
    },
    top    = 20,
    left   = 10,
    right  = 10,
    widget = wibox.container.margin,
  },
  {
    {
      top    = 15,
      widget = wibox.container.margin,
    },
    {
      {
        {
          {
            {
              text   = "RESTORE",
              font   = "JetBrainsMono Nerd Font 9",
              widget = wibox.widget.textbox,
            },
            {
              text   = "",
              halign = "center",
              widget = wibox.widget.textbox,
            },
            {
              id     = "popup_restore_dropdown_icon",
              text   = "",
              font   = "JetBrainsMono Nerd Font 12",
              widget = wibox.widget.textbox,
            },
            layout = wibox.layout.align.horizontal,
          },
          right  = 10,
          left   = 10,
          top    = 2,
          bottom = 2,
          widget = wibox.container.margin,
        },
        margins = 1,
        color   = "#fff2",
        widget  = wibox.container.margin,
      },
      id     = "popup_restore",
      bg     = "#fff1",
      widget = wibox.container.background,
    },
    {
      id      = "popup_restore_list",
      visible = true,
      layout  = wibox.layout.fixed.vertical,
    },
    layout = wibox.layout.fixed.vertical,
  },
  layout = wibox.layout.fixed.vertical,
}

local popup = awful.popup {
  ontop         = true,
  visible       = false,
  maximum_width = 500,
  offset        = { y = 5, x = 120 },
  border_width  = 0,
  border_color  = "#98c379",
  bg            = "#000",
  widget        = popup_widget,
  shape         = function(cr, width, height)
    local arrow_size = 10
    gears.shape.infobubble(cr, width, height, 0, arrow_size, (width / 2) - arrow_size)
  end,
}

local fade = require("animations.fade")
M.widget.buttons = {
  awful.button({}, 1, function()
    if popup.visible then
      fade(popup, 500, 0)
    else
      fade(popup, 500, 0, -1)

      for i, v in ipairs(mouse.current_widget_geometries) do
        if mouse.current_widgets[i].shape_border_color == "#000" then
          popup:move_next_to(v)
        end
      end
    end
  end)
}

-- ## LOGIC ##
local clients = 0
local minimized = 0
local urgent = 0

local minimized_c = {}

local widget_text = M.widget:get_children_by_id("text")[1]

local popup_total_stat     = popup.widget:get_children_by_id("popup_total_stat")[1]
local popup_minimized_stat = popup.widget:get_children_by_id("popup_minimized_stat")[1]
local popup_urgent_stat    = popup.widget:get_children_by_id("popup_urgent_stat")[1]

local popup_restore               = popup.widget:get_children_by_id("popup_restore")[1]
local popup_restore_dropdown_icon = popup.widget:get_children_by_id("popup_restore_dropdown_icon")[1]

local popup_restore_list_parent = popup.widget:get_children_by_id("popup_restore_list")[1]
local popup_restore_list        = { layout = wibox.layout.fixed.vertical }

local popup_restore_open = true
popup_restore:connect_signal("mouse::enter", function()
  popup_restore:set_bg("#fff2")
end)

popup_restore:connect_signal("mouse::leave", function()
  popup_restore:set_bg("#fff1")
end)

popup_restore.buttons = {
  awful.button({}, 1, function()
    if popup_restore_open then
      popup_restore_dropdown_icon:set_text("")
      popup_restore_list_parent.forced_height = 0
      popup_restore_open = not popup_restore_open
    else
      popup_restore_dropdown_icon:set_text("")
      popup_restore_list_parent.forced_height = nil
      popup_restore_open = not popup_restore_open
    end

    popup_restore:set_bg("#ffffff25")
    gears.timer.start_new(0.1, function()
      popup_restore:set_bg("#fff2")
    end)
  end)
}

M.update = function()
  clients = awful.screen.focused().all_clients
  minimized_c = {}
  minimized = 0
  urgent = 0

  for _, c in ipairs(client.get()) do
    if c.minimized then
      minimized = minimized + 1
      table.insert(minimized_c, c)
    end

    if c.urgent then
      urgent = urgent + 1
    end
  end

  widget_text:set_text(tostring(#clients))
  popup_total_stat:set_markup("<b>" .. tostring(#clients) .. "</b>")
  popup_minimized_stat:set_markup("<b>" .. tostring(minimized) .. "</b>")
  popup_urgent_stat:set_markup("<b>" .. tostring(urgent) .. "</b>")

  popup_restore_list = { layout = wibox.layout.fixed.vertical }
  popup_restore_list_parent:reset()

  for i = 1, minimized, 1 do
    table.insert(popup_restore_list,
      {
        {
          {
            {
              {
                text   = minimized_c[i].name,
                widget = wibox.widget.textbox,
              },
              {
                text   = "",
                halign = "center",
                widget = wibox.widget.textbox,
              },
              {
                {
                  {
                    text   = "󰁂",
                    widget = wibox.widget.textbox,
                  },
                  top    = 5,
                  bottom = 5,
                  right  = 5,
                  left   = 5,
                  widget = wibox.container.margin,
                },
                widget = wibox.container.margin,
              },
              layout = wibox.layout.align.horizontal,
            },
            left   = 10,
            right  = 2,
            top    = 2,
            bottom = 2,
            widget = wibox.container.margin,
          },
          right  = 1,
          left   = 1,
          top    = 0.5,
          bottom = 1,
          color  = "#fff2",
          widget = wibox.container.margin,
        },
        bg                 = "#ffffff0a",
        shape_border_color = "#000",
        widget             = wibox.container.background,
      })
  end

  popup_restore_list_parent:setup(popup_restore_list)

  for i, v in ipairs(popup_restore_list_parent.children[1].children) do
    v:connect_signal("mouse::enter", function()
      v.bg = "#fff1"
    end)

    v:connect_signal("mouse::leave", function()
      v.bg = "#ffffff0a"
    end)

    -- Click handle
    v.buttons = {
      awful.button({}, 1, function ()
        minimized_c[i].minimized = false
        signals:emit_signal("client_stat::restore")
      end)
    }
  end
end

-- Signals
client.connect_signal("request::manage", M.update)
client.connect_signal("request::unmanage", M.update)
client.connect_signal("property::urgent", M.update)
client.connect_signal("focus", M.update)
client.connect_signal("unfocus", M.update)
signals:connect_signal("client_stat::restore", M.update)

M.update()

return M
