return {
   -- LSP and Code Analysis
   {
      "neovim/nvim-lspconfig",
      event = "VeryLazy",
      config = function() require("config.lsp") end
   },
   {
      "nvim-treesitter/nvim-treesitter",
      lazy = false,
      build = ":TSUpdate",
      config = function() require("config.treesitter") end
   },
   { "stevearc/conform.nvim", event = "VeryLazy" },
   {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      dependencies = {
         "hrsh7th/cmp-nvim-lsp",
         "hrsh7th/cmp-buffer",
         "hrsh7th/cmp-path",
         "onsails/lspkind-nvim",
      },
   },
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
      opts = {},
      dependencies = { { "nvim-mini/mini.icons", opts = {} } },
      lazy = false,
      config = function() require("config.oil") end,
   },
   { "folke/which-key.nvim",  event = "VeryLazy" },
   -- Workflow
   {
      "folke/todo-comments.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = {},
   },
   {
      "kdheepak/lazygit.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function() require("config.lazygit") end,
   },
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
}
