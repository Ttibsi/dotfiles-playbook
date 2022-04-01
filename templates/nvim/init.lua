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
    }

    for key, value in pairs(settings) do
        vim.o[key] = value
    end
	
    -- not in vim.o
    vim.cmd('set encoding=utf-8')
    vim.cmd('set nocompatible')
    vim.cmd('set nowrap')
    vim.cmd('set tabstop=4')
    vim.cmd('set shiftwidth=4')
end

-- Set basic commands
local function custom_commands()
    vim.cmd('command! W w')
    vim.cmd('command! Q q')
    vim.cmd('command! Wq wq')

    -- Nvim 0.7 + 
    --vim.api.nvim_add_user_command('W' 'w')
    --vim.api.nvim_add_user_command('Q' 'q')
    --vim.api.nvim_add_user_command('Wq' 'wq')
end

-- Import files for plugin configs
local function call_plugins()
    require "paq" {
        "savq/paq-nvim";
        --"neovim/nvim-lspconfig";
        {"nvim-treesitter/nvim-treesitter", run=TSUpdate};
        "lukas-reineke/indent-blankline.nvim";
        "nvim-lualine/lualine.nvim";
    }

    --require 'lua.lspconfig'.init()
    --require 'treesitter_config'.init()
    --require 'indent_blankline_config'.init()
    --require 'lualine_config'.init()
end

local function init()
    basic_config()
    custom_commands()
    call_plugins()
end

init()
