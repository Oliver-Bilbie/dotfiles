local ts_filetypes = {
   "lua",
   "python",
   "rust",
   "go",
   "javascript",
   "typescript",
   "typescriptreact",
   "json",
   "yaml",
   "bash",
}

vim.api.nvim_create_autocmd("FileType", {
   group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
   pattern = ts_filetypes,
   callback = function()
      if not vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] then
         vim.treesitter.start()
      end
   end,
})

vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
