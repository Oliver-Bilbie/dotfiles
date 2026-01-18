-- Configure line numbers
vim.opt.number                = true
vim.opt.relativenumber        = true

-- Set leader key
vim.g.mapleader               = ","
vim.g.maplocalleader          = " "

-- Use system clipboard
vim.opt.clipboard             = "unnamedplus"

-- Configure indentation
vim.opt.tabstop               = 3
vim.opt.shiftwidth            = 3
vim.opt.expandtab             = true
vim.opt.smartindent           = true

-- Hide command bar when not in use
vim.o.cmdheight               = 0

-- Disable unused legacy language providers
vim.g.loaded_node_provider    = 0
vim.g.loaded_perl_provider    = 0
vim.g.loaded_ruby_provider    = 0
vim.g.loaded_python3_provider = 0

require("keymaps")
require("config.lazy")
