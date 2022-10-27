local M = {}

--TODO: Random theme at launch
M.init = function()
	local themes_install = {
		--{ "decaycs/decay.nvim", as = "decay" },
		{ "Everblush/everblush.nvim", as = "everblush" },
		{ "catppuccin/nvim", as = "catppuccin" },
		{ "ellisonleao/gruvbox", as = "gruvbox" },
	}

--  	local decay_installed, decay_plugin = pcall(require, "decay")
--  	if decay_installed then
--  		decay_plugin.setup({
--  			nvim_tree = { contrast = true },
--  		})
--  
--          table.insert(theme_list, "decay")
--  	end

	local everblush_installed, everblush_plugin = pcall(require, "everblush")
	if everblush_installed then
		local colors = require("everblush.core").get_colors()
		everblush_plugin.setup({
			override = {
				LineNr = { fg = colors.normal },
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

    local theme = "catppuccin"
    local success = pcall(vim.cmd, "colorscheme " .. theme)
    if not success then
        vim.cmd("colorscheme blue")
    end

	return themes_install
end

return M
