local dashboard = require("dashboard")

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
      action = function() require("telescope.builtin").find_files({ hidden = true, file_ignore_patterns = { "%.git/" } }) end,
      key = "f",
   },
   {
      icon = "󰘓  ",
      desc = "Find All Files                         ",
      action = function() require("telescope.builtin").find_files({ hidden = true, no_ignore = true }) end,
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
      action = function()
         require("lazy").load({ plugins = { "oil.nvim" } })
         vim.cmd("Oil")
      end,
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
      action = function()
         require("lazy").load({ plugins = { "folke/todo-comments.nvim" } })
         vim.cmd("TodoTelescope")
      end,
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

vim.api.nvim_create_autocmd("FileType", {
   pattern = "dashboard",
   group = vim.api.nvim_create_augroup("dashboard_enter", { clear = true }),
   callback = function()
      vim.keymap.set("n", "q", ":qa<CR>", { buffer = true, silent = true })
      vim.keymap.set("n", "e", ":enew<CR>", { buffer = true, silent = true })
   end,
})
