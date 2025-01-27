local api = vim.api
local keymap = vim.keymap
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
		desc = "New file                                ",
		action = "enew",
		key = "a",
	},
	{
		icon = "󰈞  ",
		desc = "Find  File                              ",
		action = "Telescope find_files",
		key = "f",
	},
	{
		icon = "  ",
		desc = "Project grep                            ",
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
		desc = "Recently opened files                   ",
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
		-- desc = "Quit Nvim                               ",
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
