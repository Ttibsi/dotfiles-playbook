local function init()
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"bash",
			"cmake",
			"cpp",
			"dockerfile",
			"go",
			"json",
			"lua",
			"python",
			"sql",
			"toml",
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
