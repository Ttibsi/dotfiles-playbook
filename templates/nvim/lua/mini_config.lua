local function active_layout()
	local mode, mode_hl =
		require("mini.statusline").section_mode({ trunc_width = 120 })
	local filename =
		require("mini.statusline").section_filename({ trunc_width = 140 })
	local fileinfo = require("mini.statusline").section_fileinfo({})
	local location =
		require("mini.statusline").section_location({ trunc_width = 5 })

	return require("mini.statusline").combine_groups({
		{ hl = mode_hl, strings = { "" } },
		{ hl = mode_hl, strings = { mode } },
		"%<", -- Mark general truncate point
		{ hl = 'require("mini.statusline")Filename', strings = { filename } },
		"%=", -- End left alignment
		{ hl = 'require("mini.statusline")Fileinfo', strings = { fileinfo } },
		{ hl = mode_hl, strings = { location } },
	})
end

local function inactive_layout()
	local mode, mode_hl =
		require("mini.statusline").section_mode({ trunc_width = 120 })
	local filename =
		require("mini.statusline").section_filename({ trunc_width = 140 })
	local fileinfo = require("mini.statusline").section_fileinfo({})

	return require("mini.statusline").combine_groups({
		{ hl = mode_hl, strings = { "" } },
		"%<", -- Mark general truncate point
		{ hl = 'require("mini.statusline")Filename', strings = { filename } },
		"%=", -- End left alignment
		{ hl = 'require("mini.statusline")Fileinfo', strings = { fileinfo } },
	})
end

local function init()
	require("mini.statusline").setup({
		content = {
			active = active_layout,
			inactive = inactive_layout,
		},
		use_icons = false,
	})

	vim.api.nvim_set_hl(
		0,
		"MiniStatuslineModeNormal",
		{ link = "MiniStatuslineModeInsert" }
	)
end

return {
	init = init,
}
