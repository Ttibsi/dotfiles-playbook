local M = {}

M.init = function()
	local themes_list = {
		{ "decaycs/decay.nvim", as = "decay" },
		{ "Everblush/everblush.nvim", as = "everblush" },
		{ "catppuccin/nvim", as = "catppuccin" },
	}

	require("decay").setup({
		nvim_tree = { contrast = true },
	})

	local colors = require("everblush.core").get_colors()
	require("everblush").setup({
		override = {
			LineNr = { fg = colors.normal },
			CursorLineNr = { fg = colors.normal },
			TSComment = { fg = colors.color7 },
		},
	})

	vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
	require("catppuccin").setup({
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

	local theme = "catppuccin"
	vim.api.nvim_exec("colorscheme " .. theme, {})

	return themes_list
end

return M
