local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")

-- Make a clock
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
	end)
)

awful.screen.connect_for_each_screen(function(s)
	-- Each screen has its own tag table.
	awful.tag({ "I", "II", "III", "IV", "V", "VI" }, s, awful.layout.layouts[1])

	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))
	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
	})

	s.mywibox = awful.wibar({
		position = "top",
		screen = s,
		layout = wibox.layout.align.horizontal,
		height = 28,
		bg = "#1E1E1E",
		widgets = { -- Left widgets
			{
				layout = wibox.layout.fixed.horizontal,

				-- Desktops
				s.mytaglist,
				-- System apps
				wibox.widget.systray(),
			},
			{ -- Middle widgets
				layout = wibox.layout.fixed.horizontal,

				-- Clock widget that opens to show a calendar
				mytextclock,
			},
			{ -- Right widgets
				layout = wibox.layout.fixed.horizontal,

				-- Layouts button
				s.mylayoutbox,
				-- Power menu
				-- Battery widget
				-- Volume
				-- Wifi/network
				-- Bluetooth?
			},
		},
	})
end)
