-- Go to start/end of line
vim.keymap.set({ 'n', 'v' }, '<S-h>', '_', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '<S-l>', '$', { noremap = true, silent = true })

-- Write
vim.keymap.set("n", "<localleader>w", "<cmd>w<cr>", { silent = true, desc = "Write" })
vim.keymap.set("n", "<localleader>W", "<cmd>wa<cr>", { silent = true, desc = "Write All" })

-- Quit
vim.keymap.set("n", "<localleader>q", "<cmd>bprevious | bdelete #<cr>", { silent = true, desc = "Quit Buffer" })
vim.keymap.set("n", "<localleader>Q", "<cmd>qa!<cr>", { silent = true, desc = "Quit Nvim" })

-- Yank Buffer
vim.keymap.set("n", "<localleader>y", "<cmd>%y<cr>", { desc = "Yank Buffer" })

-- Remap U to redo
vim.keymap.set("n", "U", "<cmd>redo<cr>")

-- Toggle spellcheck
vim.keymap.set("n", "<leader>s", "<cmd>set spell!<cr>", { desc = "Toggle Spellcheck" })
