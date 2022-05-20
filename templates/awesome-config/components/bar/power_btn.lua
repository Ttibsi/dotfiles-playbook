local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local power_btn = {}

return function()
	power_menu = awful.menu({
		items = {
			{ "Logout", "pkill -u ${USER}", beautiful.awesome_icon },
			{ "Lock", "xfce4-screensaver-command -l" },
			{ "Reboot", "reboot" },
			{ "Shutdown", "shutdown now" },
		},
	})

	power_btn = awful.widget.launcher({
		image = "~/.config/awesome/assets/icons/power_button.png",
		menu = power_menu,
	})

	return power_btn
end
