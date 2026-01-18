require("oil").setup()

vim.keymap.set("n", "<localleader>e", "<CMD>Oil<CR>", { desc = "Open directory" })

require("which-key").add({ "<localleader>e", icon = "" })
