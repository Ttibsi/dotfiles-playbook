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
		"<C-k>",
		"<cmd>lua vim.lsp.buf.signature_help()<CR>",
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
		"<leader>r",
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
	capabilities = require("cmp_nvim_lsp").default_capabilities(
		vim.lsp.protocol.make_client_capabilities()
	)

	return capabilities
end

local function init()
	local capabilities = defaults()

	-- python
	-- require("lspconfig").pylsp.setup({
	-- 	on_attach = on_attach,
	-- 	capabilities = capabilities,
	-- 	cmd = { vim.fn.expand("$HOME") .. "/.opt/venv/bin/pyls" },
	-- })
	require("lspconfig").jedi_language_server.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		cmd = {
			vim.fn.expand("$HOME") .. "/.opt/venv/bin/jedi-language-server",
		},
	})

	-- lua
	local Sumneko_root_path = vim.fn.expand("$HOME")
		.. "/.opt/lua-language-server"
	local Sumneko_binary = Sumneko_root_path .. "/bin/lua-language-server"

	require("lspconfig").lua_ls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		cmd = { Sumneko_binary, "-E", Sumneko_root_path .. "/main.lua" },
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

	if vim.loop.os_uname().sysname == "Linux" then
		Cmd =
			{ vim.fn.expand("$HOME") .. "/.opt/venv/bin/cmake-language-server" }
	else
		Cmd = { "cmake-language-server" }
	end

	--cmake
	--pip install cmake-language-server
	require("lspconfig").cmake.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		cmd = Cmd,
	})

	-- Docker
	require("lspconfig").dockerls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})

	-- Rust
	require("lspconfig").rust_analyzer.setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})

	-- zig - build from source
	require("lspconfig").zls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

return {
	init = init,
}
