local keymap = vim.keymap

-- convert git to Git in command line mode
vim.fn["utils#Cabbrev"]("git", "Git")
