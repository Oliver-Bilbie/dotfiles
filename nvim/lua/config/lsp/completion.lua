local cmp = require("cmp")

cmp.setup({
   completion = {
      completeopt = "menu,menuone,noinsert",
   },

   mapping = cmp.mapping.preset.insert({
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-y>"] = cmp.mapping.confirm({ select = true }),
      ["<Esc>"] = cmp.mapping.abort(),
   }),

   sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "buffer" },
      { name = "path" },
   }),
})

vim.o.completeopt = "menu,menuone,noinsert"
vim.o.shortmess = vim.o.shortmess .. "c"
