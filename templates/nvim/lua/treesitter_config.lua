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
			"gitcommit",
			"go",
			"help",
			"json",
			"lua",
			"make",
			"python",
			"sql",
			"toml",
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
	})
end

return {
	init = init,
}
