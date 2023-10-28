local api = vim.api
local fn = vim.fn

local utils = require("utils")

-- The root dir to install all plugins. Plugins are under opt/ or start/ sub-directory.
vim.g.plugin_home = fn.stdpath("data") .. "/site/pack/packer"

--- Install packer if it has not been installed.
--- Return:
--- true: if this is a fresh install of packer
--- false: if packer has been installed
local function packer_ensure_install()
	-- Where to install packer.nvim -- the package manager (we make it opt)
	local packer_dir = vim.g.plugin_home .. "/opt/packer.nvim"

	if fn.glob(packer_dir) ~= "" then
		return false
	end

	-- Auto-install packer in case it hasn't been installed.
	vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})

	local packer_repo = "https://github.com/wbthomason/packer.nvim"
	local install_cmd = string.format("!git clone --depth=1 %s %s", packer_repo, packer_dir)
	vim.cmd(install_cmd)

	return true
end

local fresh_install = packer_ensure_install()

-- Load packer.nvim
vim.cmd("packadd packer.nvim")

local packer = require("packer")
local packer_util = require("packer.util")

packer.startup({
	function(use)
		use({ "wbthomason/packer.nvim", opt = true })

		-- ******************************
		-- ***   LSP and completion   ***
		-- ******************************
		-- auto-completion engine
		use({ "hrsh7th/nvim-cmp", after = "lspkind-nvim", config = [[require('config.nvim-cmp')]] })
		use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" })
		use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
		use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
		use({ "hrsh7th/cmp-omni", after = "nvim-cmp" })
		use({ "quangnguyen30192/cmp-nvim-ultisnips", after = { "nvim-cmp", "ultisnips" } })
		if vim.g.is_mac then
			use({ "hrsh7th/cmp-emoji", after = "nvim-cmp" })
		end
		use({ "onsails/lspkind-nvim", event = "VimEnter" })

		-- nvim-lsp configuration (it relies on cmp-nvim-lsp, so it should be loaded after cmp-nvim-lsp).
		use({ "neovim/nvim-lspconfig", after = "cmp-nvim-lsp", config = [[require('config.lsp')]] })

		-- syntax highlighting
		use({
			"nvim-treesitter/nvim-treesitter",
			event = "BufEnter",
			run = ":TSUpdate",
			config = [[require('config.treesitter')]],
		})

		-- Python indent (follows the PEP8 style)
		use({ "Vimjas/vim-python-pep8-indent", ft = { "python" } })

		-- Python-related text object
		use({ "jeetsukumaran/vim-pythonsense", ft = { "python" } })

		use({ "machakann/vim-swap", event = "VimEnter" })
		use({ "ii14/emmylua-nvim", ft = "lua" })

		-- Snippet engine and snippet template
		use({ "SirVer/ultisnips", event = "InsertEnter" })
		use({ "honza/vim-snippets", after = "ultisnips" })

		-- GitHub Copilot
		use({
			"zbirenbaum/copilot.lua",
			cmd = "Copilot",
			event = "InsertEnter",
			config = function()
				require("copilot").setup({})
			end,
		})
		use({
			"zbirenbaum/copilot-cmp",
			after = { "copilot.lua" },
			config = function()
				require("copilot_cmp").setup()
			end,
		})

		-- ******************************
		-- *** Navigation and search  ***
		-- ******************************

		-- Show match number and index for searching
		use({
			"kevinhwang91/nvim-hlslens",
			branch = "main",
			keys = { { "n", "*" }, { "n", "#" }, { "n", "n" }, { "n", "N" } },
			config = [[require('config.hlslens')]],
		})

		-- Smooth scrolling
		use({
			"karb94/neoscroll.nvim",
			event = "VimEnter",
			config = function()
				require("neoscroll").setup()
			end,
		})

		-- File search, tag search and more
		use({
			"nvim-telescope/telescope.nvim",
			cmd = "Telescope",
			requires = { { "nvim-lua/plenary.nvim" } },
			event = "VimEnter",
		})

		-- search emoji and other symbols
		use({ "nvim-telescope/telescope-symbols.nvim", after = "telescope.nvim" })

		-- ******************************
		-- *** Making stuff look nice ***
		-- ******************************

		-- Colorsheme
		use({ "folke/tokyonight.nvim" })

		use({ "nvim-tree/nvim-web-devicons", event = "VimEnter" })

		use({
			"nvim-lualine/lualine.nvim",
			event = "BufEnter",
			config = [[require('config.lualine')]],
		})

		use({ "akinsho/bufferline.nvim", event = "VimEnter", config = [[require('config.bufferline')]] })

		-- start screen
		use({ "nvimdev/dashboard-nvim", event = "VimEnter", config = [[require('config.dashboard-nvim')]] })

		use({
			"lukas-reineke/indent-blankline.nvim",
			event = "InsertEnter",
			main = "ibl",
			config = [[require('config.indent-blankline')]],
		})

		-- Highlight URLs inside vim
		use({ "itchyny/vim-highlighturl", event = "VimEnter" })

		-- notification plugin
		use({
			"rcarriga/nvim-notify",
			event = "VimEnter",
			config = function()
				require("config.nvim-notify")
			end,
		})

		-- cmdline ui
		use({
			"folke/noice.nvim",
			event = "VimEnter",
			requires = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
			config = function()
				require("config.noice")
			end,
		})

		-- lsp loading spinner
		use({
			"j-hui/fidget.nvim",
			after = "nvim-lspconfig",
			tag = "legacy",
			config = [[require('config.fidget-nvim')]],
		})

		-- better UI for some nvim actions
		use({ "stevearc/dressing.nvim" })

		-- ******************************
		-- ***        Workflow        ***
		-- ******************************
		-- open URL in browser
		use({ "tyru/open-browser.vim", event = "VimEnter" })

		-- Comment plugin
		use({ "tpope/vim-commentary", event = "VimEnter" })

		-- ToDo Comments
		use({
			"folke/todo-comments.nvim",
			event = "VimEnter",
			dependencies = {
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-telescope/telescope.nvim" },
			},
			config = function()
				require("todo-comments").setup()
			end,
		})

		-- Manage yank history
		use({
			"gbprod/yanky.nvim",
			config = [[require('config.yanky')]],
		})

		-- Auto format tools
		use({ "sbdchd/neoformat", cmd = { "Neoformat" } })

		-- Auto-completion for cmdline
		use({ "gelguy/wilder.nvim", opt = true, setup = [[vim.cmd('packadd wilder.nvim')]] })

		-- showing keybindings
		use({
			"folke/which-key.nvim",
			event = "VimEnter",
			config = function()
				vim.o.timeout = true
				vim.o.timeoutlen = 100
				vim.defer_fn(function()
					require("config.which-key")
				end, 2000)
			end,
		})

		-- file tree
		use({
			"nvim-tree/nvim-tree.lua",
			requires = { "nvim-tree/nvim-web-devicons" },
			config = [[require('config.nvim-tree')]],
		})

		-- Git tools
		use({ "tpope/vim-fugitive", event = "User InGitRepo", config = [[require('config.fugitive')]] })
		use({ "rbong/vim-flog", requires = "tpope/vim-fugitive", cmd = { "Flog" } })
		use({ "christoomey/vim-conflicted", requires = "tpope/vim-fugitive", cmd = { "Conflicted" } })
		use({
			"ruifm/gitlinker.nvim",
			requires = "nvim-lua/plenary.nvim",
			event = "User InGitRepo",
			config = [[require('config.git-linker')]],
		})
		use({ "lewis6991/gitsigns.nvim", config = [[require('config.gitsigns')]] })
		-- Lazygit
		use({ "kdheepak/lazygit.nvim", depends = "nvim-lua/plenary.nvim" })
		-- Octo - GitHub PR and issue
		use({
			"pwntester/octo.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope.nvim",
				"nvim-tree/nvim-web-devicons",
			},
			after = "telescope.nvim",
			config = [[require('config.octo')]],
		})

		-- Markdown
		use({ "preservim/vim-markdown", ft = { "markdown" } })
		use({ "godlygeek/tabular", cmd = { "Tabularize" } })
		use({
			"iamcco/markdown-preview.nvim",
			run = function()
				vim.fn["mkdp#util#install"]()
			end,
			ft = { "markdown" },
		})

		use({ "chrisbra/unicode.vim", event = "BufEnter" })

		use({ "wellle/targets.vim", event = "BufEnter" })

		use({ "machakann/vim-sandwich", event = "BufEnter" })

		-- Modern matchit implementation
		-- use { "andymass/vim-matchup", event = "VimEnter" }

		-- ******************************
		-- ***          System        ***
		-- ******************************

		use({ "tpope/vim-scriptease", cmd = { "Scriptnames", "Message", "Verbose" } })
		use({ "MunifTanjim/nui.nvim", event = "VimEnter" })

		-- Session management plugin
		use({ "tpope/vim-obsession", cmd = "Obsession" })

		-- Yank to clipboard
		if vim.g.is_linux or vim.g.is_mac then
			use({ "ojroques/vim-oscyank", cmd = { "OSCYank", "OSCYankReg" } })
		end
	end,
	config = {
		max_jobs = 16,
		compile_path = packer_util.join_paths(fn.stdpath("data"), "site", "lua", "packer_compiled.lua"),
	},
})

-- For fresh install, we need to install plugins. Otherwise, we just need to require `packer_compiled.lua`.
if fresh_install then
	-- We run packer.sync() here, because only after packer.startup, can we know which plugins to install.
	-- So plugin installation should be done after the startup process.
	packer.sync()
else
	local status, _ = pcall(require, "packer_compiled")
	if not status then
		local msg = "File packer_compiled.lua not found: run PackerSync to fix!"
		vim.notify(msg, vim.log.levels.ERROR, { title = "nvim-config" })
	end
end

-- Auto-generate packer_compiled.lua file
api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = "*/nvim/lua/plugins.lua",
	group = api.nvim_create_augroup("packer_auto_compile", { clear = true }),
	callback = function(ctx)
		local cmd = "source " .. ctx.file
		vim.cmd(cmd)
		vim.cmd("PackerCompile")
		vim.notify("PackerCompile done!", vim.log.levels.INFO, { title = "Nvim-config" })
	end,
})
