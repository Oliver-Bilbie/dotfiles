local builtin = require('telescope.builtin')

vim.keymap.set('n', '<localleader>ft', builtin.live_grep, { desc = 'Text' })
vim.keymap.set('n', '<localleader>fb', builtin.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<localleader>fh', builtin.help_tags, { desc = 'Help' })
vim.keymap.set("n", "<localleader>fd", builtin.diagnostics, { desc = "Diagnostics" })
vim.keymap.set("n", "<localleader>fl", builtin.resume, { desc = "Last Search" })
vim.keymap.set(
   'n', '<localleader>ff',
   function() builtin.find_files({ hidden = true, file_ignore_patterns = { "%.git/" } }) end,
   { desc = 'Files' }
)
vim.keymap.set(
   'n', '<localleader>fF',
   function() builtin.find_files({ hidden = true, no_ignore = true }) end,
   { desc = 'All Files' }
)
vim.keymap.set(
   "n", "<localleader>fc",
   function() builtin.live_grep({ default_text = "<<<<<<<", prompt_title = "Merge Conflicts", }) end,
   { desc = "Merge Conflicts" }
)

require("which-key").add({ "<localleader>f", group = "Find", icon = "󰭎" })
