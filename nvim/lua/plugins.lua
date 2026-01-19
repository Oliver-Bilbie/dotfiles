return {
   -- Navigation
   {
      "nvim-telescope/telescope.nvim",
      dependencies = {
         "nvim-lua/plenary.nvim",
         { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      },
      config = function() require("config.telescope") end,
   },
   {
      "stevearc/oil.nvim",
      dependencies = "nvim-mini/mini.icons",
      keys = { { "<localleader>e", "<cmd>Oil<cr>", desc = "Open directory" } },
      config = function() require("oil").setup() end,
   },
   {
      "folke/which-key.nvim",
      event = "VeryLazy",
      config = function() require("config.which-key") end,
   },
   -- Workflow
   {
      "kdheepak/lazygit.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function() require("config.lazygit") end,
   },
   { "folke/todo-comments.nvim", opts = {} },
   { "machakann/vim-swap" },
   { "tpope/vim-surround" },
   { "wellle/targets.vim" },
   -- Display
   {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      config = function() vim.cmd.colorscheme("tokyonight-moon") end,
   },
   {
      "nvimdev/dashboard-nvim",
      event = "VimEnter",
      config = function() require("config.dashboard") end,
      dependencies = { { "nvim-tree/nvim-web-devicons" } }
   },
   {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function() require("config.lualine") end,
   },
   -- LSP and Code Analysis
   {
      "neovim/nvim-lspconfig",
      event = "VeryLazy",
      config = function() require("config.lsp") end,
      dependencies = {
         "hrsh7th/nvim-cmp",
         "hrsh7th/cmp-nvim-lsp",
         "hrsh7th/cmp-buffer",
         "hrsh7th/cmp-path",
         "onsails/lspkind-nvim",
      },
   },
   {
      "nvim-treesitter/nvim-treesitter",
      lazy = false,
      build = ":TSUpdate",
      config = function() require("config.treesitter") end
   },
   { "stevearc/conform.nvim", event = "VeryLazy" },
   -- DAP and debugging
   {
      "mfussenegger/nvim-dap",
      dependencies = { "igorlfs/nvim-dap-view" },
      keys = {
         { "<leader>b", function() require("dap").toggle_breakpoint() end },
         {
            "<leader>B",
            function()
               require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: '))
            end
         },
      },
      config = function() require("config.dap") end
   },
}
