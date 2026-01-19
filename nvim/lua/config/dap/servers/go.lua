-- See https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go-using-delve-directly

local dap = require('dap')

dap.adapters.delve = function(callback, config)
   if config.mode == 'remote' and config.request == 'attach' then
      callback({
         type = 'server',
         host = config.host or '127.0.0.1',
         port = config.port or '38697'
      })
   else
      callback({
         type = 'server',
         port = '${port}',
         executable = {
            command = 'dlv',
            args = { 'dap', '-l', '127.0.0.1:${port}', '--log', '--log-output=dap' },
            detached = vim.fn.has("win32") == 0,
         }
      })
   end
end


dap.configurations.go = {
   {
      type = "delve",
      name = "Debug",
      request = "launch",
      program = "${file}"
   },
   {
      type = "delve",
      name = "Debug test",
      request = "launch",
      mode = "test",
      program = "${file}"
   },
   {
      type = "delve",
      name = "Debug test (go.mod)",
      request = "launch",
      mode = "test",
      program = "./${relativeFileDirname}"
   }
}
