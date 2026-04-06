vim.diagnostic.config({
   underline = false,
   virtual_text = false,
   severity_sort = true,
   float = {
      border = "rounded",
      source = "always",
   },
   signs = {
      text = {
         [vim.diagnostic.severity.ERROR] = "",
         [vim.diagnostic.severity.WARN]  = "",
         [vim.diagnostic.severity.INFO]  = "",
         [vim.diagnostic.severity.HINT]  = "",
      },
   },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.buf.hover({ border = "rounded" })
