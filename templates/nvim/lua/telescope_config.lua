local function init()
	local telescope = require("telescope")
	local builtin = require("telescope.builtin")
	local telescopeConfig = require("telescope.config")

	vim.keymap.set("n", "<leader>ps", function()
		builtin.grep_string({ search = vim.fn.input("Grep > ") })
	end)

	vim.keymap.set("n", "<leader>f", builtin.find_files, {})
	vim.keymap.set("n", "<leader>g", builtin.live_grep, {})
	vim.keymap.set("n", "<leader>b", builtin.buffers, {})
	vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

	local vimgrep_arguments =
		{ unpack(telescopeConfig.values.vimgrep_arguments) }
	table.insert(vimgrep_arguments, "--hidden")
	table.insert(vimgrep_arguments, "--glob")
	table.insert(vimgrep_arguments, "!**/.git/*")

	telescope.setup({
		defaults = {
			-- `hidden = true` is not supported in text grep commands.
			vimgrep_arguments = vimgrep_arguments,
		},
		pickers = {
			find_files = {
				-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
				find_command = {
					"rg",
					"--files",
					"--hidden",
					"--glob",
					"!**/.git/*",
				},
			},
		},
	})
end

return {
	init = init,
}
