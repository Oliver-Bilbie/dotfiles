local api = vim.api
local keymap = vim.keymap
local dashboard = require("dashboard")
local builtin = require('telescope.builtin')

local conf = {}
conf.header = {
   "                                                       ",
   "                                                       ",
   "                                                       ",
   " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
   " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
   " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
   " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
   " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
   " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
   "                                                       ",
   "                                                       ",
   "                                                       ",
   "                                                       ",
}

conf.center = {
   {
      icon = "  ",
      desc = "New File                                ",
      action = "enew",
      key = "a",
   },
   {
      icon = "󰈞  ",
      desc = "Find File                              ",
      action = function() builtin.find_files({ hidden = true, file_ignore_patterns = { "%.git/" } }) end,
      key = "f",
   },
   {
      icon = "󰘓  ",
      desc = "Find All Files                         ",
      action = function() builtin.find_files({ hidden = true, no_ignore = true }) end,
      key = "F",
   },
   {
      icon = "  ",
      desc = "Project Grep                            ",
      action = "Telescope live_grep",
      key = "t",
   },
   {
      icon = "  ",
      desc = "File Browser                            ",
      action = "Oil",
      key = "e",
   },
   {
      icon = "󰥔  ",
      desc = "Recently Opened Files                   ",
      action = "Telescope oldfiles",
      key = "r",
   },
   {
      icon = "  ",
      desc = "Find ToDo                               ",
      action = "TodoTelescope",
      key = "n",
   },
   {
      icon = "󰊢  ",
      desc = "LazyGit                                 ",
      action = "LazyGit",
      key = "g",
   },
   {
      icon = "󰗼  ",
      desc = "Quit Nvim                               ",
      action = "qa",
      key = "q",
   },
}

dashboard.setup({
   theme = "doom",
   shortcut_type = "number",
   config = conf,
})

api.nvim_create_autocmd("FileType", {
   pattern = "dashboard",
   group = api.nvim_create_augroup("dashboard_enter", { clear = true }),
   callback = function()
      keymap.set("n", "q", ":qa<CR>", { buffer = true, silent = true })
      keymap.set("n", "e", ":enew<CR>", { buffer = true, silent = true })
   end,
})
