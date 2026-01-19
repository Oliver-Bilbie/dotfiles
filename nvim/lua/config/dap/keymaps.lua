local dap = require("dap")
local dap_view = require("dap-view")
dap_view.setup()

vim.keymap.set("n", ";d", function() dap.continue() end, { desc = "Debug" })
vim.keymap.set(
   "n", ";D",
   function()
      dap_view.close()
      dap.terminate()
   end,
   { desc = "Exit Debug" }
)

vim.keymap.set("n", ";R", function() dap.restart() end, { desc = "Restart Debug" })
vim.keymap.set("n", ";c", function() dap.run_to_cursor() end, { desc = "Run to Cursor" })
vim.keymap.set("n", ";C", function() dap.clear_breakpoints() end, { desc = "Clear Breakpoints" })

vim.keymap.set("n", "<F8>", function() dap.continue() end, { desc = "Continue" })
vim.keymap.set("n", "<F10>", function() dap.step_over() end, { desc = "Step Over" })
vim.keymap.set("n", "<F11>", function() dap.step_into() end, { desc = "Step Into" })
vim.keymap.set("n", "<S-F11>", function() dap.step_out() end, { desc = "Step Out" })

vim.keymap.set("n", ";w", "<cmd>DapViewShow watches<cr>", { desc = "Watches" })
vim.keymap.set("n", ";s", "<cmd>DapViewShow scopes<cr>", { desc = "Scopes" })
vim.keymap.set("n", ";e", "<cmd>DapViewShow exceptions<cr>", { desc = "Exceptions" })
vim.keymap.set("n", ";b", "<cmd>DapViewShow breakpoints<cr>", { desc = "Breakpoints" })
vim.keymap.set("n", ";t", "<cmd>DapViewShow threads<cr>", { desc = "Threads" })
vim.keymap.set("n", ";r", "<cmd>DapViewShow repl<cr>", { desc = "REPL" })

dap.listeners.after.event_initialized["dapview"] = function() dap_view.open() end
