local function init()
	require("paq")({
		{ "decaycs/decay.nvim", as = "decay" },
		{ "Everblush/everblush.nvim", as = "everblush" },
    })

    require("decay").setup({
    nvim_tree = { contrast = true },
    })

    local colors = require("everblush.core").get_colors()
    require("everblush").setup({
        override = {
            LineNr = { fg = colors.normal },
            CursorLineNr = { fg = colors.normal },
            TSComment = { fg = colors.color7 },
        },
    })

    local theme = "everblush"
    vim.api.nvim_exec("colorscheme " .. theme, {})

end

return {
    init = init,
}

