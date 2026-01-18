require("lualine").setup({
   options = {
      component_separators = "",
      section_separators = "",
      theme = "auto",
      refresh = {
         statusline = 100,
      },
   },
   sections = {
      lualine_a = {
         { function() return "" end },
      },
      lualine_b = {
         { "filetype", icon_only = true },
         { "filename", path = 1 },
      },
      lualine_c = {
         { "diagnostics", sources = { "nvim_diagnostic" } }
      },
      lualine_x = {
         {
            function()
               local reg = vim.fn.reg_recording()
               return reg ~= "" and ("Recording @" .. reg) or ""
            end,
         },
         {
            function()
               local clients = vim.lsp.get_clients({ bufnr = 0 })
               return (#clients > 0) and clients[1].name or ""
            end,
         },
      },
      lualine_y = {
         { "branch" },
         { "diff" },
      },
      lualine_z = {
      },
   },
   inactive_sections = {
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
   },
})
