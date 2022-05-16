local awful = require("awful")
local gears = require("gears")
local wallpaperdir = os.getenv("HOME") .. "/.wallpapers"
local wibox = require("wibox")

local function set_background()
	for s = 1, screen.count() do
		screen.connect_signal("request::wallpaper", function(s)
			gears.wallpaper.maximized(
				gears.filesystem.get_random_file_from_dir(
					wallpaperdir,
					{ ".jpg", ".png", ".svg", ".bmp" },
					true
				),
				s
			)
		end)
	end
end

set_background()
