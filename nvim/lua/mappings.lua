local keymap = vim.keymap
local api = vim.api
local uv = vim.loop

-- *************************************************************
--                            <space>
-- *************************************************************

-- Paste non-linewise text above or below current line, see https://stackoverflow.com/a/1346777/6064933
keymap.set("n", "<space>p", "m`o<ESC>p``", { desc = "Paste below" })
keymap.set("n", "<space>P", "m`O<ESC>p``", { desc = "Paste above" })

-- Shortcut for faster save and quit
keymap.set("n", "<space>W", "<cmd>wa<cr>", { silent = true, desc = "Save all" })
keymap.set("n", "<space>w", "<cmd>w<cr>", { silent = true, desc = "Save" })

-- Saves the file if modified and quit
keymap.set("n", "<space>q", "<cmd>x<cr>", { silent = true, desc = "Quit buffer" })

-- Quit all opened buffers
keymap.set("n", "<space>Q", "<cmd>qa!<cr>", { silent = true, desc = "Quit nvim" })

-- Insert a blank line below or above current line (do not move the cursor),
-- see https://stackoverflow.com/a/16136133/6064933
keymap.set("n", "<space>o", "printf('m`%so<ESC>``', v:count1)", {
	expr = true,
	desc = "Insert line below",
})
keymap.set("n", "<space>O", "printf('m`%sO<ESC>``', v:count1)", {
	expr = true,
	desc = "Insert line above",
})

-- Buffer navigation
keymap.set("n", "<space>b", "<cmd><cr>", { desc = "+Buffer" })
keymap.set("n", "<space>bl", "<cmd>bn<cr>", { desc = "Next" })
keymap.set("n", "<space>bh", "<cmd>bp<cr>", { desc = "Previous" })
keymap.set("n", "<space>bH", "<cmd>bfirst<cr>", { desc = "First" })
keymap.set("n", "<space>bL", "<cmd>blast<cr>", { desc = "Last" })
keymap.set("n", "<space>bc", "<cmd>bd<cr>", { desc = "Close" })
keymap.set("n", "<space>bC", "<cmd>%bd|e#|bd#<cr>", { desc = "Close others" })
keymap.set("n", "<space>by", "<cmd>%yank<cr>", { desc = "Yank" })
keymap.set("n", "<space>bf", "<cmd>Telescope buffers<cr>", { desc = "Find" })

-- Telescope
vim.keymap.set("n", "<space>f", "<cmd><cr>", {
	desc = "+Find",
})
vim.keymap.set("n", "<space>ff", "<cmd>Telescope find_files<cr>", {
	desc = "Files",
})
vim.keymap.set("n", "<space>ft", "<cmd>Telescope live_grep<cr>", {
	desc = "Text",
})
vim.keymap.set("n", "<space>fr", "<cmd>Telescope oldfiles<cr>", {
	desc = "Recent",
})
vim.keymap.set("n", "<space>fn", "<cmd>TodoTelescope<cr>", {
	desc = "ToDo",
})
vim.keymap.set("n", "<space>fd", "<cmd>Telescope diagnostics<cr>", {
	desc = "Diagnostics",
})
vim.keymap.set("n", "<space>fl", "<cmd>Telescope resume<cr>", {
	desc = "Resume",
})
vim.keymap.set("n", "<space>fy", "<cmd>YankyRingHistory<cr>", {
	desc = "Yank History",
})

vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", { desc = "Definitions" })
vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
vim.keymap.set("n", "gh", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })

-- Git
keymap.set("n", "<space>g", "<cmd><cr>", { desc = "+Git" })
keymap.set("n", "<space>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
keymap.set("n", "<space>gs", "<cmd>Git<cr>", { desc = "Git status" })
keymap.set("n", "<space>gd", "<cmd>Gdiffsplit<cr>", { desc = "Git diff" })

-- *************************************************************
--                            <leader>
-- *************************************************************

-- Markdown preview
keymap.set("n", "<leader>m", "<cmd>MarkdownPreview<cr>", { desc = "Markdown preview" })
keymap.set("n", "<leader>M", "<cmd>MarkdownPreviewStop<cr>", { desc = "Markdown preview stop" })

-- Edit and reload nvim config file
keymap.set("n", "<leader>;", "<cmd><cr>", {
	desc = "+Nvim Config",
})
keymap.set("n", "<leader>;e", "<cmd>tabnew $MYVIMRC <bar> tcd %:h<cr>", {
	silent = true,
	desc = "Open init.lua",
})
keymap.set("n", "<leader>;r", function()
	vim.cmd([[
      update $MYVIMRC
      source $MYVIMRC
    ]])
	vim.notify("Nvim config successfully reloaded!", vim.log.levels.INFO, { title = "nvim-config" })
end, {
	silent = true,
	desc = "Reload init.lua",
})
keymap.set("n", "<leader>;s", "<cmd>PackerSync<cr>", { desc = "Sync plugins" })
keymap.set("n", "<leader>f", "<cmd>Neoformat<cr>", { desc = "Format code" })

-- *************************************************************
--                          Debugging
-- *************************************************************

keymap.set("n", "<F5>", "<cmd>lua require('dap').continue()<cr>", { desc = "Continue" })
keymap.set("n", "<F10>", "<cmd>lua require('dap').step_over()<cr>", { desc = "Step over" })
keymap.set("n", "<F11>", "<cmd>lua require('dap').step_into()<cr>", { desc = "Step into" })
keymap.set("n", "<F12>", "<cmd>lua require('dap').step_out()<cr>", { desc = "Step out" })
keymap.set("n", "<leader>b", "<cmd>lua require('dap').toggle_breakpoint()<cr>", { desc = "Breakpoint" })
keymap.set(
	"n",
	"<leader>B",
	"<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
	{ desc = "Cond breakpoint" }
)

-- *************************************************************
--                            General
-- *************************************************************

-- Better scrolling
keymap.set("n", "<C-u>", "<C-u>zz", { silent = true })
keymap.set("n", "<C-d>", "<C-d>zz", { silent = true })

-- Do not include white space characters when using $ in visual mode,
-- see https://vi.stackexchange.com/q/12607/15292
keymap.set("x", "$", "g_")

-- Go to start or end of line easier
keymap.set({ "n", "x" }, "H", "^")
keymap.set({ "n", "x" }, "L", "g_")

-- Remap U to redo
keymap.set("n", "U", "<cmd>redo<cr>")

-- Continuous visual shifting (does not exit Visual mode), `gv` means
-- to reselect previous visual area, see https://superuser.com/q/310417/736190
keymap.set("x", "<", "<gv")
keymap.set("x", ">", ">gv")

-- Change text without putting it into the vim register,
-- see https://stackoverflow.com/q/54255/6064933
keymap.set("n", "c", '"_c')
keymap.set("n", "C", '"_C')
keymap.set("n", "cc", '"_cc')
keymap.set("x", "c", '"_c')

-- Replace visual selection with text in register, but not contaminate the register,
-- see also https://stackoverflow.com/q/10723700/6064933.
keymap.set("x", "p", '"_c<Esc>p')

-- Do not move my cursor when joining lines.
keymap.set("n", "J", function()
	vim.cmd([[
      normal! mzJ`z
      delmarks z
    ]])
end, {
	desc = "join line",
})

keymap.set("n", "gJ", function()
	-- we must use `normal!`, otherwise it will trigger recursive mapping
	vim.cmd([[
      normal! zmgJ`z
      delmarks z
    ]])
end, {
	desc = "join visual lines",
})

-- Break inserted text into smaller undo units when we insert some punctuation chars.
local undo_ch = { ",", ".", "!", "?", ";", ":" }
for _, ch in ipairs(undo_ch) do
	keymap.set("i", ch, ch .. "<c-g>u")
end

-- insert semicolon in the end
keymap.set("i", "<A-;>", "<Esc>miA;<Esc>`ii")

-- Keep cursor position after yanking
keymap.set("n", "y", "myy")

api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	group = api.nvim_create_augroup("restore_after_yank", { clear = true }),
	callback = function()
		vim.cmd([[
      silent! normal! `y
      silent! delmarks y
    ]])
	end,
})

-- Delete the character to the right of the cursor
keymap.set("i", "<C-DEL>", "<DEL>")

-- Remove trailing whitespace characters
keymap.set("n", "<leader><space>", "<cmd>StripTrailingWhitespace<cr>", { desc = "Fix trailing whitespace" })

-- Change current working directory locally and print cwd after that,
-- see https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
keymap.set("n", "<leader>cd", "<cmd>lcd %:p:h<cr><cmd>pwd<cr>", { desc = "CD" })

-- Toggle spell checking
keymap.set("n", "<leader>s", "<cmd>set spell!<cr>", { desc = "Toggle spell" })
