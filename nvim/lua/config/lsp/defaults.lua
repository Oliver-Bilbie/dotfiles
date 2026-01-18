local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()
pcall(function()
   M.capabilities =
       require("cmp_nvim_lsp").default_capabilities(M.capabilities)
end)

M.on_attach = function(client, bufnr)
end

return M
