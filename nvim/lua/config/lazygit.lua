vim.keymap.set("n", "<localleader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

require("which-key").add({ "<localleader>g", group = "Git", icon = "󰊢" })
