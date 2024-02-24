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
			"javascript",
			"json",
			"lua",
			"make",
			"proto",
			"python",
			"ruby",
			"rust",
			"sql",
			"toml",
			"typescript",
			"vim",
			"yaml",
            "zig",
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

	require("treesitter-context").setup({
		multiline_threshold = 2,
		trim_scope = "inner",
	})

	vim.keymap.set("n", "<leader>x", function()
		require("treesitter-context").go_to_context()
	end, { silent = true })
end

return {
	init = init,
}
