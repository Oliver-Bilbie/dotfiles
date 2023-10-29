local dap = require("dap")

-- ******************************
--             Python
-- ******************************

dap.adapters.python = function(cb, config)
	if config.request == "attach" then
		---@diagnostic disable-next-line: undefined-field
		local port = (config.connect or config).port
		---@diagnostic disable-next-line: undefined-field
		local host = (config.connect or config).host or "127.0.0.1"
		cb({
			type = "server",
			port = assert(port, "`connect.port` is required for a python `attach` configuration"),
			host = host,
			options = {
				source_filetype = "python",
			},
		})
	else
		cb({
			type = "executable",
			command = "/home/oliver/.virtualenvs/debugpy/bin/python",
			args = { "-m", "debugpy.adapter" },
			options = {
				source_filetype = "python",
			},
		})
	end
end

dap.configurations.python = {
	{
		-- The first three options are required by nvim-dap
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
			if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
				return cwd .. "/venv/bin/python"
			elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
				return cwd .. "/.venv/bin/python"
			else
				return "/usr/bin/python"
			end
		end,
	},
}

-- ******************************
--         C / C++ / Rust
-- ******************************

dap.adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-vscode",
	name = "lldb",
}

dap.configurations.c = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
	},
}

dap.configurations.cpp = dap.configurations.c

dap.configurations.rust = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			-- silently build the project
			vim.cmd("silent !cargo build")
			-- automatically point to the binary
			return vim.fn.getcwd() .. "/target/debug/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
	},
}

-- ******************************
--               Go
-- ******************************

dap.adapters.delve = {
	type = "server",
	port = "${port}",
	executable = {
		command = "dlv",
		args = { "dap", "-l", "127.0.0.1:${port}" },
	},
}

dap.configurations.go = {
	{
		type = "delve",
		name = "Debug",
		request = "launch",
		program = "${file}",
	},
	{
		type = "delve",
		name = "Debug test",
		request = "launch",
		mode = "test",
		program = "${file}",
	},
	{
		type = "delve",
		name = "Debug test (go.mod)",
		request = "launch",
		mode = "test",
		program = "./${relativeFileDirname}",
	},
}

-- ******************************
--           JavaScript
-- ******************************

dap.adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = "node",
		-- TODO: Fix this path
		args = { "/path/to/js-debug/src/dapDebugServer.js", "${port}" },
	},
}

dap.configurations.javascript = {
	{
		type = "pwa-node",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		cwd = "${workspaceFolder}",
	},
}

dap.configurations.typescript = dap.configurations.javascript
dap.configurations.javascriptreact = dap.configurations.javascript
dap.configurations.typescriptreact = dap.configurations.javascript
