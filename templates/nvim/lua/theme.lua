local M = {}

--TODO: Random theme at launch
M.init = function()
	local themes_install = {
		{ "decaycs/decay.nvim", as = "decay" },
		{ "Everblush/everblush.nvim", as = "everblush" },
		{ "catppuccin/nvim", as = "catppuccin" },
		{ "ellisonleao/gruvbox.nvim", as = "gruvbox" },
		{ "folke/tokyonight.nvim", as = "tokyonight" },
		{ "navarasu/onedark.nvim", as = "onedark" },
		{ "rebelot/kanagawa.nvim", as = "kanagawa" },
		{ "rose-pine/neovim", as = "rose-pine" },
		{ "EdenEast/nightfox.nvim", as = "nightfox" },
	}

	local decay_installed, decay_plugin = pcall(require, "decay")
	if decay_installed then
		decay_plugin.setup({
			nvim_tree = { contrast = true },
		})
	end

	local everblush_installed, everblush_plugin = pcall(require, "everblush")
	if everblush_installed then
		local colors = require("everblush.core").get_colors()
		everblush_plugin.setup({
			override = {
				LineNr = { fg = colors.color7 }, --This doesnt owrk
				CursorLineNr = { fg = colors.normal },
				TSComment = { fg = colors.color7 },
			},
		})
	end

	local catppuccin_installed, catppuccin_plugin = pcall(require, "catppuccin")
	if catppuccin_installed then
		vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
		catppuccin_plugin.setup({
			integrations = {
				gitsigns = true,
				treesitter = true,
				treesitter_context = false,

				indent_blankline = {
					enabled = true,
					colored_indent_levels = true,
				},
				native_lsp = {
					enabled = true,
				},
			},
		})
	end

	local gruvbox_installed, gruvbox_plugin = pcall(require, "gruvbox")

	local tokyonight_installed, tokyonight_plugin = pcall(require, "tokyonight")
	if tokyonight_installed then
		tokyonight_plugin.setup({
			style = "night", -- storm, night, moon, day
		})
	end

	local onedark_installed, onedark_plugin = pcall(require, "onedark")
	if onedark_installed then
		onedark_plugin.setup({
			style = "deep", -- dark, darker, cool, deep, warm, warmer, light
		})
	end

	local kanagawa_installed, kanagawa_plugin = pcall(require, "kanagawa")

	local rosepine_installed, rosepine_plugin = pcall(require, "rose-pine")
	if rosepine_installed then
		rosepine_plugin.setup({
			dark_variant = "main", -- options: main, moon

			-- -- Change specific vim highlight groups
			highlight_groups = {
				ColorColumn = { bg = "rose" },
			},
		})
	end

	local nightfox_installed, nightfox_plugin = pcall(require, "nightfox")
	-- Options: Carbonfox, dawnfox, dayfox, duskfox, nightfox, nordfox, terafox

	local theme = "kanagawa"
	local success = pcall(vim.cmd, "colorscheme " .. theme)
	if not success then
		vim.cmd("colorscheme blue")
	end

	return themes_install
end

return M
