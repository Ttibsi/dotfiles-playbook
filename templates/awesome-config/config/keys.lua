local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")
local menubar = require("menubar")

terminal = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod1"

-- Mouse bindings
root.buttons(gears.table.join(
	awful.button({}, 3, function()
		mymainmenu:toggle()
	end),
	awful.button({}, 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev)
))

-- Key bindings
globalkeys = gears.table.join(

	-- AWESOMEWM
	awful.key(
		{ modkey },
		"s",
		hotkeys_popup.show_help,
		{ description = "show help", group = "awesomeWM" }
	),
	awful.key(
		{ modkey },
		"Escape",
		awful.tag.history.restore,
		{ description = "go back", group = "awesomeWM" }
	),
	awful.key({ modkey }, "w", function()
		mymainmenu:show()
	end, { description = "show main menu", group = "awesomeWM" }),
	awful.key(
		{ modkey, "Shift" },
		"r",
		awesome.restart,
		{ description = "reload awesome", group = "awesomeWM" }
	),
	awful.key(
		{ modkey, "Shift" },
		"q",
		awesome.quit,
		{ description = "quit awesome", group = "awesomeWM" }
	),

	-- LAYOUTS
	awful.key({ modkey }, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "layout" }),
	awful.key({ modkey }, "k", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous by index", group = "layout" }),
	awful.key({ modkey, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "layout" }),
	awful.key(
		{ modkey, "Shift" },
		"k",
		function()
			awful.client.swap.byidx(-1)
		end,
		{ description = "swap with previous client by index", group = "layout" }
	),
	awful.key({ modkey }, "f", function()
		awful.layout.inc(1)
	end, { description = "select next layout", group = "layout" }),
	awful.key({ modkey, "Shift" }, "f", function()
		awful.layout.inc(-1)
	end, { description = "select previous layout", group = "layout" }),
	awful.key({ modkey }, "l", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),
	awful.key({ modkey }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),
	awful.key(
		{ modkey },
		"u",
		awful.client.urgent.jumpto,
		{ description = "jump to urgent client", group = "layout" }
	),
	awful.key(
		{ modkey },
		"space",
		awful.client.floating.toggle,
		{ description = "toggle floating", group = "layout" }
	),

	-- LAUNCH PROGRAMS
	awful.key({ modkey }, "Return", function()
		awful.spawn(terminal)
	end, { description = "open a terminal", group = "launcher" }),
	awful.key({ modkey }, "d", function()
		awful.spawn.with_shell(
			"rofi -show run -config ~/.config/awesome/assets/rofi/config.rasi"
		)
	end, { description = "Rofi search bar", group = "launcher" }),
	awful.key({ modkey }, "x", function()
		awful.prompt.run({
			prompt = "Run Lua code: ",
			textbox = awful.screen.focused().mypromptbox.widget,
			exe_callback = awful.util.eval,
			history_path = awful.util.get_cache_dir() .. "/history_eval",
		})
	end, { description = "lua execute prompt", group = "launcher" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	globalkeys = gears.table.join(
		globalkeys,
		-- View tag only.
		awful.key({ modkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, { description = "view tag #" .. i, group = "tag" }),
		-- Toggle tag display.
		awful.key({ modkey, "Control" }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, { description = "toggle tag #" .. i, group = "tag" }),
		-- Move client to tag.
		awful.key(
			{ modkey, "Shift" },
			"#" .. i + 9,
			function()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:move_to_tag(tag)
					end
				end
			end,
			{ description = "move focused client to tag #" .. i, group = "tag" }
		),
		-- Toggle tag on focused client.
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, {
			description = "toggle focused client on tag #" .. i,
			group = "tag",
		})
	)
end

clientkeys = gears.table.join(awful.key({ modkey }, "q", function(c)
	c:kill()
end, { description = "close window", group = "awesomeWM" }))

clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

-- Set keys
root.keys(globalkeys)

return keys
