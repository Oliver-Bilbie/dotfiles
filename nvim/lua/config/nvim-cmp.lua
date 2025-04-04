-- Setup nvim-cmp.
local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
	snippet = {
		expand = function(args)
			-- For `ultisnips` user.
			vim.fn["UltiSnips#Anon"](args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-j>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end,
		["<C-k>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end,
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-n>"] = cmp.mapping.close(),
	}),
	sources = {
		{ name = "nvim_lsp" }, -- For nvim-lsp
		{ name = "path" }, -- for path completion
		-- { name = "copilot" }, -- for GitHub copilot
		{ name = "ultisnips" }, -- For ultisnips user.
		{ name = "buffer", keyword_length = 2 }, -- for buffer word completion
	},
	completion = {
		keyword_length = 1,
		completeopt = "menu,noselect",
	},
	view = {
		entries = "custom",
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text",
			menu = {
				nvim_lsp = "[LSP]",
				ultisnips = "[US]",
				nvim_lua = "[Lua]",
				path = "[Path]",
				buffer = "[Buffer]",
				emoji = "[Emoji]",
				omni = "[Omni]",
			},
		}),
		format = lspkind.cmp_format({
			mode = "symbol",
			max_width = 50,
			symbol_map = { Copilot = "" },
		}),
	},
})

cmp.setup.filetype("tex", {
	sources = {
		{ name = "omni" },
		{ name = "ultisnips" }, -- For ultisnips user.
		{ name = "buffer", keyword_length = 2 }, -- for buffer word completion
		{ name = "path" }, -- for path completion
	},
})

--  see https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-dark-theme-colors-to-the-menu
vim.cmd([[
  highlight! link CmpItemMenu Comment
  " gray
  highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
  " blue
  highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
  highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
  " light blue
  highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
  highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
  highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
  " pink
  highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
  highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
  " front
  highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
  highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
  highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
]])
