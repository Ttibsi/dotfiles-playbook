-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr, opts)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	local opts = { noremap = true, silent = true }

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"gD",
		"<cmd>lua vim.lsp.buf.declaration()<CR>",
		opts
	)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"gd",
		"<cmd>lua vim.lsp.buf.definition()<CR>",
		opts
	)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"K",
		"<cmd>lua vim.lsp.buf.hover()<CR>",
		opts
	)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"gi",
		"<cmd>lua vim.lsp.buf.implementation()<CR>",
		opts
	)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<C-k>",
		"<cmd>lua vim.lsp.buf.signature_help()<CR>",
		opts
	)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<leader>wa",
		"<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
		opts
	)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<leader>wr",
		"<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
		opts
	)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<leader>wl",
		"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
		opts
	)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<leader>D",
		"<cmd>lua vim.lsp.buf.type_definition()<CR>",
		opts
	)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<leader>R",
		"<cmd>lua vim.lsp.buf.rename()<CR>",
		opts
	)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<leader>c",
		"<cmd>lua vim.lsp.buf.code_action()<CR>",
		opts
	)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"gr",
		"<cmd>lua vim.lsp.buf.references()<CR>",
		opts
	)
	--vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local function defaults()
	local opts = { noremap = true, silent = true }

	-- Mappings from nvim-lsp.
	-- See `:help vim.diagnostic.*` for documentation on any of the below functions
	vim.api.nvim_set_keymap(
		"n",
		"<leader>w",
		"<cmd>lua vim.diagnostic.open_float()<CR>",
		opts
	)
	vim.api.nvim_set_keymap(
		"n",
		"[d",
		"<cmd>lua vim.diagnostic.goto_prev()<CR>",
		opts
	)
	vim.api.nvim_set_keymap(
		"n",
		"]d",
		"<cmd>lua vim.diagnostic.goto_next()<CR>",
		opts
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>q",
		"<cmd>lua vim.diagnostic.setloclist()<CR>",
		opts
	)

	-- This is from nvim-cmp
	capabilities = require("cmp_nvim_lsp").update_capabilities(
		vim.lsp.protocol.make_client_capabilities()
	)

	return capabilities
end

function scandir(directory)
	local i, t, popen = 0, {}, io.popen
	local pfile = popen('ls -A "' .. directory .. '"')
	for filename in pfile:lines() do
		i = i + 1
		t[i] = filename
	end
	pfile:close()
	return t
end

local function init()
	capabilities = defaults()

	-- python
	require("lspconfig").pyright.setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})

	-- lua

	if vim.loop.os_uname().sysname == "Darwin" then
		local sumneko_version =
			scandir("/usr/local/Cellar/lua-language-server")[1]
		sumneko_root_path = "/usr/local/Cellar/lua-language-server/"
			.. sumneko_version
		sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"
	else
		sumneko_root_path = vim.fn.expand("$HOME")
			.. "/.opt/lua-language-server"
		sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"
	end


	require("lspconfig").sumneko_lua.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
					-- Setup your lua path
					path = vim.split(package.path, ";"),
				},
				-- Get the language server to recognize the `vim` global
				diagnostics = { globals = { "vim" } },
				-- Make the server aware of Neovim runtime files
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = { enable = false },
			},
		},
	})

	-- golang
	require("lspconfig").gopls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})

	-- C++
	require("lspconfig").clangd.setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})

	--cmake
	--pip install cmake-language-server
	require("lspconfig").cmake.setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})

	-- Docker
	require("lspconfig").dockerls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

return {
	init = init,
}
