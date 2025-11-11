local api = vim.api
local keymap = vim.keymap
local lsp = vim.lsp
local diagnostic = vim.diagnostic

local utils = require("utils")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

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

	local diag_float_grp = api.nvim_create_augroup("LspDiagFloat", { clear = true })

	api.nvim_create_autocmd("CursorHold", {
		group = diag_float_grp,
		buffer = bufnr,
		callback = function()
			local float_opts = {
				focusable = false,
				border = "rounded",
				_source = "always",
				prefix = " ",
			}
			diagnostic.open_float(nil, float_opts)
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

-- ╭──────────────────────────────────────────────────────────╮
-- │ 1. Global LSP Defaults (Neovim 0.11+ style)              │
-- ╰──────────────────────────────────────────────────────────╯

vim.lsp.config("*", {
	on_attach = custom_attach,
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 200,
	},
})

-- ╭──────────────────────────────────────────────────────────╮
-- │ 2. Language servers (Neovim 0.11+ style)                 │
-- ╰──────────────────────────────────────────────────────────╯

-- Python (pylsp)
if utils.executable("pylsp") then
	local venv_path = os.getenv("VIRTUAL_ENV")
	local py_path = venv_path and (venv_path .. "/bin/python3") or vim.g.python3_host_prog

	vim.lsp.config.pylsp = {
		settings = {
			pylsp = {
				plugins = {
					black = { enabled = true },
					pylint = { enabled = true, executable = "pylint" },
					pylsp_mypy = {
						enabled = true,
						overrides = { "--python-executable", py_path, true },
						report_progress = true,
						live_mode = false,
					},
					jedi_completion = { fuzzy = true },
					isort = { enabled = true },
					bandit = { enabled = true },
				},
			},
		},
	}
	vim.lsp.enable("pylsp")
end

-- C / C++
if utils.executable("clangd") then
	vim.lsp.config.clangd = {
		filetypes = { "c", "cpp", "cc" },
		cmd = { "clangd", "--offset-encoding=utf-16" },
		flags = { debounce_text_changes = 500 },
	}
	vim.lsp.enable("clangd")
end

-- Vimscript
if utils.executable("vim-language-server") then
	vim.lsp.config.vimls = {
		flags = { debounce_text_changes = 500 },
	}
	vim.lsp.enable("vimls")
end

-- Bash
if utils.executable("bash-language-server") then
	vim.lsp.enable("bashls")
end

-- Lua
if utils.executable("lua-language-server") then
	vim.lsp.config.lua_ls = {
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				diagnostics = { globals = { "vim" } },
				workspace = {
					library = {
						vim.fn.stdpath("data") .. "/site/pack/packer/opt/emmylua-nvim",
						vim.fn.stdpath("config"),
					},
					maxPreload = 2000,
					preloadFileSize = 50000,
				},
			},
		},
	}
	vim.lsp.enable("lua_ls")
end

-- TypeScript / JavaScript (using the correct check/key)
if utils.executable("tsserver") then
	vim.lsp.config.ts_ls = {
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
	}
	vim.lsp.enable("ts_ls")
end

-- ESLint
if utils.executable("vscode-eslint-language-server") then
	vim.lsp.config.eslint = {
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
	}
	vim.lsp.enable("eslint")
end

-- Rust
if utils.executable("rust-analyzer") then
	vim.lsp.config.rust_analyzer = {}
	vim.lsp.enable("rust_analyzer")
end

-- Go
if utils.executable("gopls") then
	vim.lsp.config.gopls = {}
	vim.lsp.enable("gopls")
end

-- Terraform
if utils.executable("terraform-ls") then
	vim.lsp.config.terraformls = {
		filetypes = { "terraform", "tf" },
	}
	vim.lsp.enable("terraformls")
end

-- YAML
if utils.executable("yaml-language-server") then
	vim.lsp.config.yamlls = {
		filetypes = { "yaml", "yml" },
	}
	vim.lsp.enable("yamlls")
end

-- R
if utils.executable("R") then
	vim.lsp.config.r_language_server = {
		cmd = { "R", "--slave", "-e", "languageserver::run()" },
		filetypes = { "r", "rmd" },
	}
	vim.lsp.enable("r_language_server")
end

-- ╭──────────────────────────────────────────────────────────╮
-- │ 3. Custom handlers                                       │
-- ╰──────────────────────────────────────────────────────────╯
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

-- global config for diagnostic
diagnostic.config({
	underline = false,
	virtual_text = false,
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
	},
})
