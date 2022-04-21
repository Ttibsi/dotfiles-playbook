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
        colorcolumn = '80',
        colorcolumn = '88',

        -- This is for nvim-cmp
        completeopt = {
            "menu",
            "menuone",
            "noselect"
        }
    }

    for key, value in pairs(settings) do
        vim.opt[key] = value
    end
	
    -- not in vim.o
    vim.cmd('set encoding=utf-8')
    vim.cmd('set nocompatible')
    vim.cmd('set nowrap')
    vim.cmd('set tabstop=4')
    vim.cmd('set shiftwidth=4')

    -- set leader
    vim.g.mapleader = "'"
end

-- Set basic commands
local function custom_commands()
    -- Nvim 0.7 +
    vim.api.nvim_create_user_command('W', 'w', {})
    vim.api.nvim_create_user_command('Q', 'q', {})
    vim.api.nvim_create_user_command('Wq', 'wq', {})
end

-- Import files for plugin configs
local function call_plugins()
    require "paq" {
        "savq/paq-nvim";

        "neovim/nvim-lspconfig";
        "hrsh7th/nvim-cmp";
        "hrsh7th/cmp-nvim-lsp";
        "hrsh7th/cmp-buffer";
        "hrsh7th/cmp-path";
        "L3MON4D3/LuaSnip";
        "saadparwaiz1/cmp_luasnip";

        {"nvim-treesitter/nvim-treesitter", run=TSUpdate};
        "lukas-reineke/indent-blankline.nvim";
        "nvim-lualine/lualine.nvim";

        "catppuccin/nvim";
    }

    vim.cmd[[colorscheme catppuccin]]
    require 'lsp_config'.init()
    require 'cmp_config'.init()
    require 'treesitter_config'.init()
    require 'indent_blankline_config'.init()
    require 'lualine_config'.init()
end

local function init()
    basic_config()
    custom_commands()
    call_plugins()
end

init()
