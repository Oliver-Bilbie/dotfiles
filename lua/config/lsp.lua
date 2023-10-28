local fn = vim.fn
local api = vim.api
local keymap = vim.keymap
local lsp = vim.lsp
local diagnostic = vim.diagnostic

local utils = require("utils")

-- set quickfix list from diagnostics in a certain buffer, not the whole workspace
local set_qflist = function(buf_num, severity)
	local diagnostics = nil
	diagnostics = diagnostic.get(buf_num, { severity = severity })

	local qf_items = diagnostic.toqflist(diagnostics)
	vim.fn.setqflist({}, " ", { title = "Diagnostics", items = qf_items })

	-- open quickfix by default
	vim.cmd([[copen]])
end

local custom_attach = function(client, bufnr)
	-- Mappings.
	local map = function(mode, l, r, opts)
		opts = opts or {}
		opts.silent = true
		opts.buffer = bufnr
		keymap.set(mode, l, r, opts)
	end

	map("n", "<C-]>", vim.lsp.buf.definition)
	map("n", "K", vim.lsp.buf.hover)
	map("n", "<C-k>", vim.lsp.buf.signature_help)
	map("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename variable" })
	map("n", "[d", diagnostic.goto_prev, { desc = "previous diagnostic" })
	map("n", "]d", diagnostic.goto_next, { desc = "next diagnostic" })

  map("n", "<leader>f", "<cmd>Neoformat<cr>", { desc = "format code" })

	api.nvim_create_autocmd("CursorHold", {
		buffer = bufnr,
		callback = function()
			local float_opts = {
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				border = "rounded",
				source = "always", -- show source in diagnostic popup window
				prefix = " ",
			}

			if not vim.b.diagnostics_pos then
				vim.b.diagnostics_pos = { nil, nil }
			end

			local cursor_pos = api.nvim_win_get_cursor(0)
			if
				(cursor_pos[1] ~= vim.b.diagnostics_pos[1] or cursor_pos[2] ~= vim.b.diagnostics_pos[2])
				and #diagnostic.get() > 0
			then
				diagnostic.open_float(nil, float_opts)
			end

			vim.b.diagnostics_pos = cursor_pos
		end,
	})

	-- The blow command will highlight the current variable and its usages in the buffer.
	if client.server_capabilities.documentHighlightProvider then
		vim.cmd([[
      hi! link LspReferenceRead Visual
      hi! link LspReferenceText Visual
      hi! link LspReferenceWrite Visual
    ]])

		local gid = api.nvim_create_augroup("lsp_document_highlight", { clear = true })
		api.nvim_create_autocmd("CursorHold", {
			group = gid,
			buffer = bufnr,
			callback = function()
				lsp.buf.document_highlight()
			end,
		})

		api.nvim_create_autocmd("CursorMoved", {
			group = gid,
			buffer = bufnr,
			callback = function()
				lsp.buf.clear_references()
			end,
		})
	end

	if vim.g.logging_level == "debug" then
		local msg = string.format("Language server %s started!", client.name)
		vim.notify(msg, vim.log.levels.DEBUG, { title = "Nvim-config" })
	end
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require("lspconfig")

if utils.executable("pylsp") then
	local venv_path = os.getenv("VIRTUAL_ENV")
	local py_path = nil
	-- decide which python executable to use for mypy
	if venv_path ~= nil then
		py_path = venv_path .. "/bin/python3"
	else
		py_path = vim.g.python3_host_prog
	end

	lspconfig.pylsp.setup({
		on_attach = custom_attach,
		settings = {
			pylsp = {
				plugins = {
					-- formatter options
					black = { enabled = true },
					-- linter options
					pylint = { enabled = true, executable = "pylint" },
					-- type checker
					pylsp_mypy = {
						enabled = true,
						overrides = { "--python-executable", py_path, true },
						report_progress = true,
						live_mode = false,
					},
					-- auto-completion options
					jedi_completion = { fuzzy = true },
					-- import sorting
					isort = { enabled = true },
					bandit = { enabled = true },
				},
			},
		},
		flags = {
			debounce_text_changes = 200,
		},
		capabilities = capabilities,
	})
else
	vim.notify("pylsp not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end

if utils.executable("clangd") then
	lspconfig.clangd.setup({
		on_attach = custom_attach,
		capabilities = capabilities,
		filetypes = { "c", "cpp", "cc" },
		flags = {
			debounce_text_changes = 500,
		},
	})
end

-- set up vim-language-server
if utils.executable("vim-language-server") then
	lspconfig.vimls.setup({
		on_attach = custom_attach,
		flags = {
			debounce_text_changes = 500,
		},
		capabilities = capabilities,
	})
else
	vim.notify("vim-language-server not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end

-- set up bash-language-server
if utils.executable("bash-language-server") then
	lspconfig.bashls.setup({
		on_attach = custom_attach,
		capabilities = capabilities,
	})
end

if utils.executable("lua-language-server") then
	-- settings for lua-language-server can be found on https://github.com/LuaLS/lua-language-server/wiki/Settings .
	lspconfig.lua_ls.setup({
		on_attach = custom_attach,
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files,
					-- see also https://github.com/LuaLS/lua-language-server/wiki/Libraries#link-to-workspace .
					-- Lua-dev.nvim also has similar settings for lua ls, https://github.com/folke/neodev.nvim/blob/main/lua/neodev/luals.lua .
					library = {
						fn.stdpath("data") .. "/site/pack/packer/opt/emmylua-nvim",
						fn.stdpath("config"),
					},
					maxPreload = 2000,
					preloadFileSize = 50000,
				},
			},
		},
		capabilities = capabilities,
	})
end

-- set up typescript-language-server
if utils.executable("tsserver") then
	lspconfig.tsserver.setup({
		on_attach = custom_attach,
		capabilities = capabilities,
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
			"json",
		},
	})
end

-- set up eslint language server
if utils.executable("vscode-eslint-language-server") then
	lspconfig.eslint.setup({
		on_attach = custom_attach,
		capabilities = capabilities,
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
	})
end

-- set up rust-analyzer
if utils.executable("rust-analyzer") then
	lspconfig.rust_analyzer.setup({
		on_attach = custom_attach,
		capabilities = capabilities,
	})
end

-- set up terraform-ls
if utils.executable("terraform-ls") then
	lspconfig.terraformls.setup({
		on_attach = custom_attach,
		capabilities = capabilities,
		filetypes = { "terraform", "tf" },
	})
end

-- set up yaml-language-server
if utils.executable("yaml-language-server") then
	lspconfig.yamlls.setup({
		on_attach = custom_attach,
		capabilities = capabilities,
		filetypes = { "yaml", "yml" },
	})
end

-- Change diagnostic signs.
fn.sign_define("DiagnosticSignError", { text = '', texthl = "DiagnosticSignError" })
fn.sign_define("DiagnosticSignWarn", { text = '', texthl = "DiagnosticSignWarn" })
fn.sign_define("DiagnosticSignInfo", { text = '', texthl = "DiagnosticSignInfo" })
fn.sign_define("DiagnosticSignHint", { text = '', texthl = "DiagnosticSignHint" })

-- global config for diagnostic
diagnostic.config({
	underline = false,
	virtual_text = false,
	signs = true,
	severity_sort = true,
})

-- lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
--   underline = false,
--   virtual_text = false,
--   signs = true,
--   update_in_insert = false,
-- })

-- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
lsp.handlers["textDocument/hover"] = lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})
