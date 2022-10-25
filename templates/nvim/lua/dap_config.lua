local dap = require("dap")

local function adapters()
	-- C++/C/Rust
	dap.adapters.lldb = {
		type = "executable",
		command = "/usr/local/opt/llvm/bin/lldb-vscode", -- adjust as needed, must be absolute path
	}

	--Python
	dap.adapters.python = {
		type = "executable",
		command = "python3",
		args = { "-m", "debugpy.adapter" },
	}
end

local function configurations()
	dap.configurations.cpp = {
		{
			name = "Launch",
			type = "lldb",
			request = "launch",
			program = function()
				return vim.fn.input(
					"Path to executable: ",
					vim.loop.cwd() .. "/",
					"file"
				)
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			args = {},
		},
	}

	dap.configurations.python = {
		{
			type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
			request = "launch",
			name = "Launch file",

			-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
			program = "${file}", -- This configuration will launch the current file if used.
			pythonPath = function()
				-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
				-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
				-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
				local cwd = vim.fn.getcwd()
				if vim.fn.executable(cwd .. "/venv/bin/python3") == 1 then
					return cwd .. "/venv/bin/python3"
				elseif vim.fn.executable(cwd .. "/.venv/bin/python3") == 1 then
					return cwd .. "/.venv/bin/python3"
				else
					return "/usr/bin/python3"
				end
			end,
		},
	}
end

local function keymaps()
	--nvim-dap
	vim.keymap.set(
		"n",
		"<leader>db",
		":lua require'dap'.toggle_breakpoint()<CR>"
	)
	vim.keymap.set(
		"n",
		"<leader>dB",
		":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>"
	)
	vim.keymap.set("n", "<leader>di", ":lua require'dap'.step_into()<CR>")
	vim.keymap.set("n", "<leader>dn", ":lua require'dap'.step_over()<CR>")
	vim.keymap.set("n", "<leader>dp", ":lua require'dap'.step_back()<CR>")
	vim.keymap.set("n", "<leader>dc", ":lua require'dap'.continue()<CR>")

	-- dap-ui
	vim.keymap.set("n", "<leader>dr", ":lua require'dapui'.open()<CR>")
end

local function init()
	require("nvim-dap-virtual-text").setup()
	require("dapui").setup({})

	adapters()
	configurations()
	keymaps()
end

return { init = init }
