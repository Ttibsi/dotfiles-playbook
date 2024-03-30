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
	capabilities = require("cmp_nvim_lsp").default_capabilities(
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

local function cssCapabilities()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	return capabilities
end

local function init()
	capabilities = defaults()

	-- python
	require("lspconfig").pylsp.setup({
		on_attach = on_attach,
		capabilities = capabilities,
        cmd = {vim.fn.expand("$HOME") .. "/.opt/venv/bin/pyls"}
	})

	-- lua
	if vim.loop.os_uname().sysname == "Darwin" then
		local sumneko_version =
			scandir("/usr/local/Cellar/lua-language-server")[1]
		Sumneko_root_path = "/usr/local/Cellar/lua-language-server/"
			.. sumneko_version
			.. "/libexec"
		Sumneko_binary = Sumneko_root_path .. "/bin/lua-language-server"
	else
		print("May need to fix path")
		Sumneko_root_path = vim.fn.expand("$HOME")
			.. "/.opt/lua-language-server"
		Sumneko_binary = Sumneko_root_path .. "/bin/lua-language-server"
	end

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

	-- Typescript
	-- requres `npm i typescript-language-server`
	require("lspconfig").tsserver.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		cmd = { "npx", "typescript-language-server", "--stdio" },
	})

	-- Css
	-- requires `npm i vscode-langservers-extracted`
	require("lspconfig").cssls.setup({
		on_attach = on_attach,
		capabilities = cssCapabilities(),
		cmd = { "npx", "vscode-css-language-server", "--stdio" },
	})

	--Ruby
	-- gem install rubyls
	require("lspconfig").ruby_ls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})

 --    -- zig - build from source
	require("lspconfig").zls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

return {
	init = init,
}
