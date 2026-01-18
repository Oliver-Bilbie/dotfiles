local defaults = require("config.lsp.defaults")

-- Global defaults (applies to all servers)
vim.lsp.config("*", {
   on_attach = defaults.on_attach,
   capabilities = defaults.capabilities,
})

-- Per-server overrides
vim.lsp.config.lua_ls = {
   settings = {
      Lua = {
         diagnostics = { globals = { "vim" } },
      },
   },
}

vim.lsp.enable({
   "clangd",
   "gopls",
   "rust_analyzer",
   "pyright",
   "ts_ls",
   "eslint",
   "terraformls",
   "yamlls",
   "bashls",
   "lua_ls",
   "vim-language-server",
})
