local builtin = require('telescope.builtin')
local action_state = require('telescope.actions.state')
local actions = require('telescope.actions')
local themes = require('telescope.themes')

vim.keymap.set('n', '<localleader>ft', builtin.live_grep, { desc = 'Text' })
vim.keymap.set('n', '<localleader>fh', builtin.help_tags, { desc = 'Help' })
vim.keymap.set("n", "<localleader>fd", builtin.diagnostics, { desc = "Diagnostics" })
vim.keymap.set("n", "<localleader>fl", builtin.resume, { desc = "Last Search" })
vim.keymap.set(
   "n", "<localleader>fw",
   function() builtin.grep_string(themes.get_dropdown({})) end,
   { desc = "Word" }
)
vim.keymap.set(
   "n", "<localleader>fn",
   function()
      require("lazy").load({ plugins = { "todo-comments.nvim" } })
      vim.cmd("TodoTelescope")
   end,
   { desc = "ToDo" }
)
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

BUFFER_SEARCH = function()
   builtin.buffers {
      sort_mru = true,
      ignore_current_buffer = true,
      show_all_buffers = false,
      attach_mappings = function(prompt_bufnr, map)
         local refresh_buffer_searcher = function()
            actions.close(prompt_bufnr)
            vim.schedule(BUFFER_SEARCH)
         end

         local delete_buf = function()
            local selection = action_state.get_selected_entry()
            vim.api.nvim_buf_delete(selection.bufnr, { force = true })
            refresh_buffer_searcher()
         end

         local delete_multiple_buf = function()
            local picker = action_state.get_current_picker(prompt_bufnr)
            local selection = picker:get_multi_selection()
            for _, entry in ipairs(selection) do
               vim.api.nvim_buf_delete(entry.bufnr, { force = true })
            end
            refresh_buffer_searcher()
         end

         map('n', 'dd', delete_buf)
         map('n', '<C-d>', delete_multiple_buf)
         map('i', '<C-d>', delete_multiple_buf)

         return true
      end
   }
end
vim.keymap.set('n', '<localleader>fb', BUFFER_SEARCH, { desc = "Buffers" })
