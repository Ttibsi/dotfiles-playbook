local M = {}

--TODO: Random theme at launch
M.init = function()
	local themes_install = {
		-- Decay's not updated for 0.9 yet
		-- { "decaycs/decay.nvim", as = "decay" },
		{ "Everblush/nvim", as = "everblush" },
		{ "catppuccin/nvim", as = "catppuccin" },
		{ "ellisonleao/gruvbox.nvim", as = "gruvbox" },
		{ "folke/tokyonight.nvim", as = "tokyonight" },
		{ "navarasu/onedark.nvim", as = "onedark" },
		{ "rebelot/kanagawa.nvim", as = "kanagawa" },
		{ "rose-pine/neovim", as = "rose-pine" },
		{ "EdenEast/nightfox.nvim", as = "nightfox" },
		{ "w3barsi/barstrata.nvim", as = "barstrata" },
		{ "Mofiqul/dracula.nvim", as = "dracula" },
		{ "nyoom-engineering/oxocarbon.nvim", as = "oxocarbon" },
	}

	local decay_installed, decay_plugin = pcall(require, "decay")
	if decay_installed then
		decay_plugin.setup({
			nvim_tree = { contrast = true },
		})
	end

	local everblush_installed, everblush_plugin = pcall(require, "everblush")

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
			style = "darker", -- dark, darker, cool, deep, warm, warmer, light
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

	local barstrata_installed, barstrata_plugin = pcall(require, "barstrata")

	local dracula_installed, dracula_plugin = pcall(require, "dracula")
	if dracula_installed then
		dracula_plugin.setup({
			lualine_bg_color = "#44475a",
		})
	end

	local oxocarbon_installed, oxocarbon_plugin = pcall(require, "oxocarbon")

	local theme = "gruvbox"
	local success = pcall(vim.cmd, "colorscheme " .. theme)
	if not success then
		vim.cmd("colorscheme blue")
	end

	-- Translucency
	vim.cmd("highlight Normal ctermbg=none guibg=none")
	vim.cmd("highlight NonText ctermbg=none guibg=none")

	return themes_install
end

return M
