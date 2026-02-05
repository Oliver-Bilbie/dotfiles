vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set(
   "n", "<leader>f",
   function() require("conform").format({ async = true, lsp_fallback = true }) end,
   { desc = "Format" }
)

local builtin = require('telescope.builtin')
local themes = require('telescope.themes')
vim.keymap.set(
   "n", "gd",
   function() builtin.lsp_definitions(themes.get_dropdown({})) end,
   { desc = "Definition" }
)
vim.keymap.set(
   "n", "gr",
   function() builtin.lsp_references(themes.get_dropdown({})) end,
   { desc = "References" }
)
