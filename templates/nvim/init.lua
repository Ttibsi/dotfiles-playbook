-- vim config started 16/Oct/2021
-- converted to lua starting 26/Mar/2022 with Framework laptop purchase at nvim 0.6.1

-- Only for basic "set x" vim commands
local function basic_config()
	local settings = {
		background = dark,
		encoding = "utf-8",
		hlsearch = false,
		wrap = false,

		expandtab = true,
		smartindent = true,
		scrolloff = 5,
		shiftwidth = 4,
		tabstop = 4,

		number = true,
		ruler = true,
		cursorline = true,
		colorcolumn = "80",
		mouse = "",

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

	-- not in vim.o - do :h option-list
	vim.cmd("set nocompatible")

	-- set leader
	vim.g.mapleader = "'"

	-- Global variables
	vim.g.netrw_banner = 0
	vim.g.netrw_winsize = 25
end

-- Set basic commands
local function custom_commands()
	vim.api.nvim_create_user_command("W", "w", {})
	vim.api.nvim_create_user_command("Q", "q", {})
	vim.api.nvim_create_user_command("Wq", "wq", {})

	-- Copy and Paste
	vim.keymap.set("n", "<leader>y", '"+y')
	vim.keymap.set("v", "<leader>y", '"+y')
	vim.keymap.set("n", "<leader>p", ":put+<CR>", {})

	-- Tabs
	vim.keymap.set("n", "<leader>t", ":tabnew<CR>", {})
	vim.keymap.set("n", "<leader>n", ":tabnext<CR>", {})
	vim.keymap.set("n", "<leader>N", ":tabprev<CR>", {})

	-- Splits
	vim.keymap.set("n", "<leader>s", ":new<CR>")
	vim.keymap.set("n", "<leader>v", ":vnew<CR>")

	vim.keymap.set("n", "<leader>h", "<C-w>h")
	vim.keymap.set("n", "<leader>j", "<C-w>j")
	vim.keymap.set("n", "<leader>k", "<C-w>k")
	vim.keymap.set("n", "<leader>l", "<C-w>l")

	-- Navigation
	vim.keymap.set("n", "<leader>e", ":Ex<CR>")
	-- vim.keymap.set("n", "a", "$")

	-- Move selected lines up/down
	vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
	vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
end

-- Import files for plugin configs
local function call_plugins()
	local themes_list = require("theme").init()
	local plugins_list = {
		"savq/paq-nvim",

		"neovim/nvim-lspconfig",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"mfussenegger/nvim-dap",
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",

		{ "nvim-treesitter/nvim-treesitter", run = TSUpdate },
		"nvim-treesitter/nvim-treesitter-context",
		"lukas-reineke/indent-blankline.nvim",
		"nvim-lualine/lualine.nvim",
		"lewis6991/gitsigns.nvim",

		"numToStr/Comment.nvim",
		"ellisonleao/glow.nvim",
		"ttibsi/pre-commit.nvim",
	}

	for _, theme in ipairs(themes_list) do
		table.insert(plugins_list, theme)
	end

	require("paq"):setup({})(plugins_list)
	require("cmp_config").init()
	require("dap_config").init()
	require("indent_blankline_config").init()
	require("lsp_config").init()
	require("lualine_config").init()
	require("treesitter_config").init()

	require("Comment").setup()
	require("gitsigns").setup()
end

local function init()
	basic_config()
	custom_commands()
	call_plugins()
end

init()
