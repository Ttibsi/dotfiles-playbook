-- vim config started 16/Oct/2021
-- converted to lua starting 26/Mar/2022 with Framework laptop purchase at nvim 0.6.1

-- Only for basic "set x" vim commands
local function basic_config()
	local settings = {
		background = dark,
		encoding = "utf-8",
		termguicolors = true,
		hlsearch = false,
		wrap = false,
		incsearch = true,
		smartcase = true,

		-- ttyfast = true, -- Faster in terminal.app

		expandtab = true,
		smartindent = true,
		scrolloff = 5,
		shiftwidth = 4,
		tabstop = 4,

		number = true,
		ruler = true,
		-- cursorline = true,
		-- colorcolumn = "80",
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
	vim.g.netrw_liststyle = 3
end

local function remap(input, result)
	vim.keymap.set("n", input, result)
	vim.keymap.set("t", input, result)
end

-- Set basic commands
local function custom_commands()
	vim.api.nvim_create_user_command("W", "w", {})
	vim.api.nvim_create_user_command("Q", "q", {})
	vim.api.nvim_create_user_command("Wq", "wq", {})

	-- Copy and Paste
	remap("<leader>y", '"+y')
	vim.keymap.set("v", "<leader>y", '"+y')
	remap("<leader>p", ":put+<CR>")

	-- Tabs
	remap("<leader>t", ":tabnew<CR>")
	remap("<leader>n", ":tabnext<CR>")
	remap("<leader>N", ":tabprev<CR>")

	-- Splits
	remap("<leader>s", ":new<CR>")
	remap("<leader>v", ":vnew<CR>")

	-- Split navigation
	remap("<leader>h", "<C-w>h")
	remap("<leader>j", "<C-w>j")
	remap("<leader>k", "<C-w>k")
	remap("<leader>l", "<C-w>l")

	-- Navigation
	remap("<leader>e", ":Ex<CR>")

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
		--"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		{ "nvim-telescope/telescope.nvim", branch = "0.1.x" },
		"nvim-telescope/telescope-fzf-native.nvim",

		{ "nvim-treesitter/nvim-treesitter", run = TSUpdate },

		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/playground",
		-- "lukas-reineke/indent-blankline.nvim",
		"nvim-lualine/lualine.nvim",
		-- "lewis6991/gitsigns.nvim",

		"numToStr/Comment.nvim",
		"folke/todo-comments.nvim",
		-- "ellisonleao/glow.nvim",
		"ttibsi/pre-commit.nvim",
		-- "levouh/tint.nvim",
	}

	for _, theme in ipairs(themes_list) do
		table.insert(plugins_list, theme)
	end

	require("paq"):setup({})(plugins_list)
	require("cmp_config").init()
	--require("dap_config").init()
	-- require("indent_blankline_config").init()
	require("lsp_config").init()
	require("lualine_config").init()
	require("telescope_config").init()
	require("treesitter_config").init()

	require("Comment").setup()
	-- require("gitsigns").setup()
	-- require("tint").setup({})
	require("todo-comments").setup()
end

-- TODO: Replace lualine
-- https://github.com/tjdevries/config_manager/blob/357b61f2675f265f897a830fb22c1cbbbf109630/xdg_config/nvim/after/plugin/statusline.lua
local function init()
	basic_config()
	custom_commands()
	call_plugins()
end

init()
