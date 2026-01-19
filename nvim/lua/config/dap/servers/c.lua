-- See https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#c-c-rust-via-gdb

local dap = require("dap")

dap.adapters.gdb = {
   type = "executable",
   command = "gdb",
   args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
}

dap.configurations.c = {
   {
      name = "Launch",
      type = "gdb",
      request = "launch",
      program = function()
         return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      args = {}, -- provide arguments if needed
      cwd = "${workspaceFolder}",
      stopAtBeginningOfMainSubprogram = false,
   }
}

dap.configurations.cpp = dap.configurations.c
