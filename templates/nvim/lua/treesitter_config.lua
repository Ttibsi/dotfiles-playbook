local function init()
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"bash",
			"cmake",
			"comment",
			"cpp",
			"diff",
			"dockerfile",
			"git_rebase",
			"go",
			"gomod",
			"help",
			"javascript",
			"json",
			"lua",
			"make",
			"proto",
			"python",
			"rust",
			"sql",
			"toml",
			"typescript",
			"vim",
			"yaml",
		},

		sync_install = false,

		highlight = {
			enable = true,
		},

		incremental_selection = {
			enable = true,
		},

		indent = {
			enable = true,
		},

		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["if"] = "@function.inner",
					["af"] = "@function.outer",
					["ic"] = "@class.inner",
					["ac"] = "@class.outer",
					["ia"] = "@parameter.inner",
					["aa"] = "@parameter.outer",
				},
			},
		},
	})
end

return {
	init = init,
}
