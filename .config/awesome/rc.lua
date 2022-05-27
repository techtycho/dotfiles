-- ~/.config/awesome/rc.lua
--  _______ _______
-- |__   __|__   __|	 Author: Omar Ahmed (TechTycho)
--    | |     | |	 Date: 1st of December 2021
--    | |     | |
--    |_|     |_|	 GitHub: https://github.com/techtycho
--
-- My rc.lua.
-- Thanks for cloning!
--
-- NOTE: This may contain some errors and stuff so be careful. I'll also test this not in the very distant future.

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local fa_icons = require("widgets.fa-icons")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("~/.config/awesome/themes/github/theme.lua") -- Loads the themes

-- {{{ Widgets
local current_layout = require("widgets.layout") -- The layout widget, displays info about the current layout.
local battery = require("widgets.battery") -- The battery widget, displays the battery percentage.
local temprature = require("widgets.temprature") -- The temprature widget, displays the CPU temprature.
local storage  = require("widgets.storage") -- The storage widget, shows how much disk storage you have consumed.
local volume = require("widgets.volume") -- The volume widgets, displays the audio volume.

-- {{{ Tasklist tweaks
-- This is just for hiding the tasklist
beautiful.tasklist_disable_task_name = true -- No window titles
beautiful.tasklist_disable_icon = true -- No window icons
beautiful.tasklist_plain_task_name = true -- No icons indicating window status. eg: "+" for maximized.
beautiful.tasklist_bg_focus = "#141d29" -- No color; color is the same as the panel color.

-- This is used later as the default terminal and editor to run.
terminal = "alacritty" -- My favourite terminal
editor = "gedit" -- The only GUI I know, for now. Change it if you want.
editor_cmd = terminal .. " -e " .. "nvim" -- My favourite text editor, Emacs Enthusiasts and Nano Users may wanna change this.

-- Favourite Programs
browser = "brave" -- Change to Firefox or LibreWolf if you want.

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4" -- The 'Super' key

-- Table of layouts to cover with awful.layout.inc, order matters.
-- I don't use many layouts, these wil just work for me.
awful.layout.layouts = {
    awful.layout.suit.tile, -- Tiling
    awful.layout.suit.floating, -- Floating
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral, -- Spiral
    awful.layout.suit.spiral.dwindle, -- Dwindle
    awful.layout.suit.max, -- Max
    -- awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier, -- Magnifier
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}

-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
-- My AwesomeWM main menu.
myawesomemenu = {
   { "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end }, -- Take a quick look at the hotkeys.
   { "Manual", terminal .. " -e man awesome" }, -- See the manual
   { "Configure", editor_cmd .. " " .. awesome.conffile }, -- Configure AwesomeWM, this does not refer to the rc.lua in the home directory (~/.config/awesome/)
   { "Restart", awesome.restart }, -- Restart AwesomeWM
   { "Quit", function() awesome.quit() end }, -- Quit AwesomeWM
}

-- Custom menu that I made, covers all the browsers.
-- Add whatever browser you want to add here.
browsers = {
	{ "Brave",  browser}, -- Brave (my default browser)
	{ "Firefox", "firefox"}, -- Firefox
}

-- The main menu, only accessible by right click since there is no launcher widget
mymainmenu = awful.menu({ items = { { "Awesome", myawesomemenu }, -- The AwesomeWM main menu
                                    { "Terminal", terminal }, -- Open a terminal
				    { "Browsers", browsers }, -- Open the browsers menu
                                  }
                        })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1]) -- I included only five, I want simplicity, and I won't use 9 different tags.

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,

    }

	textclock = wibox.widget {
		format = '  [%H:%M]',
		widget = wibox.widget.textclock,
	}

	calendar = wibox.widget {
		format = ' %A, %b %d  ',
		widget = wibox.widget.textclock,
	}

    volume_icon = wibox.widget {
        image = os.getenv("HOME") .. "/.config/awesome/widget-icons/volume.png",
        resize = true,
        widget = wibox.widget.imagebox,
    }

	storage_icon = wibox.widget {
		image = os.getenv("HOME") .. "/.config/awesome/widget-icons/storage.png",
		resize = true,
		widget = wibox.widget.imagebox,
	}

	calendar_icon = wibox.widget {
		image = os.getenv("HOME") .. "/.config/awesome/widget-icons/calendar.png",
		resize = true,
		widget = wibox.widget.imagebox,
	}

	temprature_icon = wibox.widget {
		image = os.getenv("HOME") .. "/.config/awesome/widget-icons/temprature.png",
		resize = true,
		widget = wibox.widget.imagebox,
	}

	language_icon = wibox.widget {
		image = os.getenv("HOME") .. "/.config/awesome/widget-icons/language.png",
		resize = true,
		widget = wibox.widget.imagebox,
	}

	battery_icon = wibox.widget {
		image = os.getenv("HOME") .. "/.config/awesome/widget-icons/battery.png",
		resize = true,
		widget = wibox.widget.imagebox,
	}

	local calendar_clr = wibox.widget.background()
	calendar_clr:set_widget(calendar)
	calendar_clr:set_fg("#e33a6e")

	local keyboardlayout_clr = wibox.widget.background()
	keyboardlayout_clr:set_widget(mykeyboardlayout)
	keyboardlayout_clr:set_fg("#6e7ea3")

	local textclock_clr = wibox.widget.background()
	textclock_clr:set_widget(textclock)
	textclock_clr:set_fg("#cc581f")

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
			volume_icon,
			volume,
			storage_icon,
			storage,
			calendar_icon,
			calendar_clr,
			temprature_icon,
			temprature,
			battery_icon,
			battery,
			language_icon,
            keyboardlayout_clr,
            wibox.widget.systray(),
            textclock_clr,
			current_layout,
		},
    }
	end)

-- Keyboard Layout Managment
kbdcfg = {}
kbdcfg.cmd = "setxkbmap"
kbdcfg.layout = { "us", "ar" }
kbdcfg.current = 1  -- us is default
kbdcfg.switch = function ()
   kbdcfg.current = kbdcfg.current % #(kbdcfg.layout) + 1
   os.execute(kbdcfg.cmd .. " " .. kbdcfg.layout[kbdcfg.current])
end

-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        { description = "focus next by index", group = "client" }
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    awful.key({ modkey,          }, "b", function() awful.util.spawn(browser) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    -- Menubar
    awful.key({ modkey }, "p", function() awful.util.spawn("dmenu_run -fn 'JetBrains Mono Nerd Font-9' -p 'Run:' -sb '#4a4e69' -h 24") end,
              {description = "show the menubar", group = "launcher"}),

	awful.key({modkey}, "d", function() awful.util.spawn("thunar") end),

	-- Audio Control
	awful.key({}, "XF86AudioRaiseVolume", function() awful.util.spawn("amixer set Master 2%+") end),
	awful.key({}, "XF86AudioLowerVolume", function() awful.util.spawn("amixer set Master 2%-") end),	
	awful.key({}, "XF86AudioMute", function() awful.util.spawn("amixer set Master toggle") end),
	awful.key({}, "XF86AudioMute", function() awful.util.spawn("amixer set Speaker unmute") end),

	-- Keyboard Layout Control
	awful.key({ modkey }, "Shift_R", function () kbdcfg.switch() end),
    awful.key({ modkey }, "r", function() awful.util.spawn("radio") end),
    awful.key({ modkey }, "z", function() quake:toggle() end)
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
          "galculator",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
          "win0",
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    -- -- Add titlebars to floating clients
    -- client.connect_signal("property::floating", function(c)
    --     if c.floating then
    --         awful.titlebar.show(c)
    --     else
    --         awful.titlebar.hide(c)
    --     end
    -- end)

    -- -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)


-- screen.connect_signal("arrange", function (s)
--     local max = s.selected_tag.layout.name == "max"
--     local only_one = #s.tiled_clients == 1 -- use tiled_clients so that other floating windows don't affect the count
--     -- but iterate over clients instead of tiled_clients as tiled_clients doesn't include maximized windows
--     for _, c in pairs(s.clients) do
--         if (max or only_one) and not c.floating or c.maximized then
--             c.border_width = beautiful.border_width
--         else
--             c.border_width = 0
--         end
--     end
-- end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    beautiful.titlebar_bg = "#222222"

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.closebutton    (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.maximizedbutton(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            -- { -- Title
            --     align  = "center",
            --     widget = awful.titlebar.widget.titlewidget(c)
            -- },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Autorun programs
autorun = true
autorunApps = {
    "picom --experimental-backends",
    "nitrogen --restore"
}

if autorun then
    for _, app in ipairs(autorunApps) do
		awful.util.spawn(app)
    end
end
-- }}}
