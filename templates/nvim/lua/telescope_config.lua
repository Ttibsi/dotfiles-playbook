local function init()
	print("Hello from telescope")
	local builtin = require("telescope.builtin")
	vim.keymap.set("n", "<leader>f", builtin.find_files, {})
	vim.keymap.set("n", "<leader>g", builtin.live_grep, {})
	vim.keymap.set("n", "<leader>b", builtin.buffers, {})
	vim.keymap.set("n", "<leader>h", builtin.help_tags, {})
end

return {
	init = init,
}
