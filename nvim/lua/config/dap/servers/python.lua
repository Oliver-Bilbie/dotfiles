-- See https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#python

local dap = require('dap')

dap.adapters.python = function(cb, config)
   if config.request == 'attach' then
      local port = (config.connect or config).port
      local host = (config.connect or config).host or '127.0.0.1'
      cb({
         type = 'server',
         port = assert(port, '`connect.port` is required for a python `attach` configuration'),
         host = host,
         options = { source_filetype = 'python' },
      })
   else
      cb({
         type = 'executable',
         command = os.getenv("HOME") .. "/.virtualenvs/debugpy/bin/python",
         args = { '-m', 'debugpy.adapter' },
         options = { source_filetype = 'python' },
      })
   end
end

dap.configurations.python = {
   {
      type = 'python',
      request = 'launch',
      name = "Launch file",
      program = "${file}",
      pythonPath = function()
         local python_venv = os.getenv("VIRTUAL_ENV")
         if python_venv ~= nil then
            return python_venv .. "/bin/python"
         else
            return vim.fn.exepath("python3") or vim.fn.exepath("python")
         end
      end,
   },
}
