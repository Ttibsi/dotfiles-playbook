local term = require("wezterm")

return {
	-- https://wezfurlong.org/wezterm/colorschemes/index.html
	-- color_scheme = "CloneofUbuntu (Gogh)",
	-- color_scheme = "nightfox",
	color_scheme = "Chalk",
	font = term.font(
		"Meslo LG M for Powerline",
		{ weight = "Regular", stretch = "Normal", style = "Normal" }
	),
	font_size = 11,
	use_fancy_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = false,
	-- window_background_opacity = 0.9,
	cursor_blink_rate = 800,
	window_padding = {
		left = 4,
		right = 4,
		top = 2,
		bottom = 0,
	},
	keys = {
		{
			key = ",",
			mods = "CMD",
			action = term.action.SplitHorizontal({
				domain = "CurrentPaneDomain",
			}),
		},
		{
			key = ".",
			mods = "CMD",
			action = term.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
	},
}
