-- vim config started 16/Oct/2021
-- converted to lua starting 26/Mar/2022 with Framework laptop purchase at nvim 0.6.1

-- Only for basic "set x" vim commands
local function basic_config()
	local settings = {
		background = dark,

		expandtab = true,
		smartindent = true,
		scrolloff = 5,

		number = true,
		ruler = true,
		cursorline = true,
		colorcolumn = "80",

		splitbelow = true,
		splitright = true,

		-- This is for nvim-cmp
		completeopt = {
			"menu",
			"menuone",
			"noselect",
		},
	}

	for key, value in pairs(settings) do
		vim.opt[key] = value
	end

	-- not in vim.o
	vim.cmd("set encoding=utf-8")
	vim.cmd("set nocompatible")
	vim.cmd("set nowrap")
	vim.cmd("set tabstop=4")
	vim.cmd("set shiftwidth=4")

	-- set leader
	vim.g.mapleader = "'"
end

-- Set basic commands
local function custom_commands()
	vim.api.nvim_create_user_command("W", "w", {})
	vim.api.nvim_create_user_command("Q", "q", {})
	vim.api.nvim_create_user_command("Wq", "wq", {})

	-- Copy and Paste
	vim.keymap.set("v", "<C-c>", ":'<, '>y +<CR>", {})
	vim.keymap.set("n", "<leader>p", ":put+<CR>", {})

	-- Tabs
	vim.keymap.set("n", "Tt", ":tabnew<CR>", {})
	vim.keymap.set("n", "Tn", ":tabnext<CR>", {})
	vim.keymap.set("n", "Tp", ":tabprev<CR>", {})

	-- Splits
	vim.keymap.set("n", "<leader>s", ":new<CR>")
	vim.keymap.set("n", "<leader>v", ":vnew<CR>")

	vim.keymap.set("n", "<leader>h", "<C-w>h")
	vim.keymap.set("n", "<leader>j", "<C-w>j")
	vim.keymap.set("n", "<leader>k", "<C-w>k")
	vim.keymap.set("n", "<leader>l", "<C-w>l")

	-- Navigation
	vim.keymap.set("n", "<leader>e", ":Ex<CR>")
end

-- Import files for plugin configs
local function call_plugins()
	require("paq")({
		"savq/paq-nvim",

		"neovim/nvim-lspconfig",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",

		{ "nvim-treesitter/nvim-treesitter", run = TSUpdate },
		"lukas-reineke/indent-blankline.nvim",
		"nvim-lualine/lualine.nvim",

		"numToStr/Comment.nvim",

		{ "decaycs/decay.nvim", as = "decay" },
	})

	-- colourscheme
	require("decay").setup({
		nvim_tree = { contrast = true },
	})

	-- Background Translucency
	-- This has to be set after the colourscheme
	vim.api.nvim_set_hl(0, "Normal", {})
	vim.api.nvim_set_hl(0, "NonText", {})

	require("lsp_config").init()
	require("cmp_config").init()
	require("treesitter_config").init()
	require("indent_blankline_config").init()
	require("lualine_config").init()

	require("Comment").setup()
end

local function init()
	basic_config()
	custom_commands()
	call_plugins()
end

init()
