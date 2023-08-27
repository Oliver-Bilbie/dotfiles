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
keymap.set("n", "<space>W", "<cmd>Neoformat | update<cr>", { silent = true, desc = "Save & Format" })
keymap.set("n", "<space>w", "<cmd>update<cr>", { silent = true, desc = "Save" })

-- Saves the file if modified and quit
keymap.set("n", "<space>q", "<cmd>x<cr>", { silent = true, desc = "Quit current window" })

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

-- Hop in normal and visual mode
keymap.set("n", "<space>h", "<cmd>HopChar1<cr>", { desc = "Hop" })
keymap.set("v", "<space>h", "<cmd>HopChar1<cr>", { desc = "Hop" })

-- Buffer navigation
keymap.set("n", "<space>b", "<cmd><cr>", { desc = "+Buffer" })
keymap.set("n", "<space>bl", '<cmd>bn<cr>', { desc = "Next" })
keymap.set("n", "<space>bh", '<cmd>bp<cr>', { desc = "Previous" })
keymap.set("n", "<space>bk", '<cmd>bfirst<cr>', { desc = "First" })
keymap.set("n", "<space>bj", '<cmd>blast<cr>', { desc = "Last" })
keymap.set("n", "<space>bc", '<cmd>bd<cr>', { desc = "Close" })
keymap.set("n", "<space>by", "<cmd>%yank<cr>", { desc = "Yank" })

-- Window navigation
keymap.set("n", "<space>v", "<cmd><cr>", {
  desc = "+Window"
})
keymap.set("n", "<space>vh", "<c-w>h", {
  desc = "Left",
})
keymap.set("n", "<space>vl", "<C-W>l", {
  desc = "Right",
})
keymap.set("n", "<space>vk", "<C-W>k", {
  desc = "Up",
})
keymap.set("n", "<space>vj", "<C-W>j", {
  desc = "Down",
})

-- Floaterm
keymap.set("n", "<space>t", "<cmd>FloatermToggle<cr>", {
  desc = "Terminal"
})

-- Telescope
vim.keymap.set('n', '<space>f', "<cmd><cr>", {
  desc = "+Find"
})
vim.keymap.set('n', '<space>ff', "<cmd>Telescope find_files<cr>", {
  desc = "Files"
})
vim.keymap.set('n', '<space>ft', "<cmd>Telescope live_grep<cr>", {
  desc = "Text"
})
vim.keymap.set('n', '<space>fr', "<cmd>Telescope oldfiles<cr>", {
  desc = "Recent"
})
vim.keymap.set('n', '<space>fb', "<cmd>Telescope git_branches<cr>", {
  desc = "Branches"
})
vim.keymap.set('n', '<space>fc', "<cmd>Telescope git_commits<cr>", {
  desc = "Commits"
})
vim.keymap.set('n', '<space>fs', "<cmd>Telescope git_stash<cr>", {
  desc = "Stash"
})
vim.keymap.set('n', '<space>fg', "<cmd>Telescope git_status<cr>", {
  desc = "Git status"
})
vim.keymap.set('n', '<space>fn', "<cmd>TodoTelescope<cr>", {
  desc = "ToDo"
})
vim.keymap.set('n', '<space>fe', "<cmd>Telescope diagnostics<cr>", {
  desc = "Diagnostics"
})
vim.keymap.set('n', '<space>fl', "<cmd>Telescope resume<cr>", {
  desc = "Resume"
})

vim.keymap.set('n', 'gd', "<cmd>Telescope lsp_definitions<cr>", { desc = "Definitions" })
vim.keymap.set('n', 'gr', "<cmd>Telescope lsp_references<cr>", { desc = "References" })
vim.keymap.set('n', 'gh', "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })

-- Git
keymap.set("n", "<space>g", "<cmd><cr>", { desc = "+Git" })
keymap.set("n", "<space>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
keymap.set("n", "<space>gs", "<cmd>Git<cr>", { desc = "Git status" })
keymap.set("n", "<space>gw", "<cmd>Gwrite<cr>", { desc = "Git add" })
keymap.set("n", "<space>gc", "<cmd>Git commit<cr>", { desc = "Git commit" })
keymap.set("n", "<space>gd", "<cmd>Gdiffsplit<cr>", { desc = "Git diff" })
keymap.set("n", "<space>gpl", "<cmd>Git pull<cr>", { desc = "Git pull" })
keymap.set("n", "<space>gpu", "<cmd>15 split|term git push<cr>", { desc = "Git push" })

-- *************************************************************
--                            <leader>
-- *************************************************************

-- Edit and reload nvim config file
keymap.set("n", "<leader>;", "<cmd><cr>", {
  desc = "+Nvim Config"
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
keymap.set("n", "<leader>;s", "<cmd>PackerSync<cr>", {desc = "Sync plugins"})

-- *************************************************************
--                            General
-- *************************************************************

-- Better scrolling
keymap.set("n", "<C-u>", "<C-u>zz", { silent = true })
keymap.set("n", "<C-d>", "<C-d>zz", { silent = true })
vim.o.scrolloff = 8

-- Move the cursor based on physical lines, not the actual lines.
keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap.set("n", "^", "g^")
keymap.set("n", "0", "g0")

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

-- Always use very magic mode for searching
keymap.set("n", "/", [[/\v]])

-- Exit floating terminal
keymap.set("t", "<leader>t", "<cmd>FloatermToggle<cr>")
keymap.set("t", "<leader><leader>", [[<c-\><c-n>]])

-- Change text without putting it into the vim register,
-- see https://stackoverflow.com/q/54255/6064933
keymap.set("n", "c", '"_c')
keymap.set("n", "C", '"_C')
keymap.set("n", "cc", '"_cc')
keymap.set("x", "c", '"_c')

-- Replace visual selection with text in register, but not contaminate the register,
-- see also https://stackoverflow.com/q/10723700/6064933.
keymap.set("x", "p", '"_c<Esc>p')

-- Move current line up and down
keymap.set("n", "<A-k>", '<cmd>call utils#SwitchLine(line("."), "up")<cr>', { desc = "move line up" })
keymap.set("n", "<A-j>", '<cmd>call utils#SwitchLine(line("."), "down")<cr>', { desc = "move line down" })

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
keymap.set("i", "<C-L>", "<DEL>")

-- Navigation in the location and quickfix list
keymap.set("n", "[l", "<cmd>lprevious<cr>zv", { silent = true, desc = "Previous location item" })
keymap.set("n", "]l", "<cmd>lnext<cr>zv", { silent = true, desc = "Next location item" })

keymap.set("n", "[L", "<cmd>lfirst<cr>zv", { silent = true, desc = "First location item" })
keymap.set("n", "]L", "<cmd>llast<cr>zv", { silent = true, desc = "Last location item" })

keymap.set("n", "[q", "<cmd>cprevious<cr>zv", { silent = true, desc = "Previous qf item" })
keymap.set("n", "]q", "<cmd>cnext<cr>zv", { silent = true, desc = "Next qf item" })

keymap.set("n", "[Q", "<cmd>cfirst<cr>zv", { silent = true, desc = "First qf item" })
keymap.set("n", "]Q", "<cmd>clast<cr>zv", { silent = true, desc = "Last qf item" })

-- Close location list or quickfix list if they are present, see https://superuser.com/q/355325/736190
keymap.set("n", [[\x]], "<cmd>windo lclose <bar> cclose <cr>", {
  silent = true,
  desc = "Close qf and location list",
})

-- Remove trailing whitespace characters
keymap.set("n", "<leader><space>", "<cmd>StripTrailingWhitespace<cr>", { desc = "Fix trailing whitespace" })

-- Change current working directory locally and print cwd after that,
-- see https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
keymap.set("n", "<leader>cd", "<cmd>lcd %:p:h<cr><cmd>pwd<cr>", { desc = "CD" })

-- Toggle spell checking
keymap.set("n", "<leader>s", "<cmd>set spell!<cr>", { desc = "Toggle spell" })

-- Blink the cursor
keymap.set("n", "<leader><leader>", function()  
	local cnt = 0
  local blink_times = 7
	local timer = uv.new_timer()

	timer:start(0, 100, vim.schedule_wrap(function()
		vim.cmd[[
			set cursorcolumn!
			set cursorline!      
		]]                    

		if cnt == blink_times then
			timer:close()        
		end                    

		cnt = cnt + 1          
	end))
end, { desc = "Blink cursor"})

-- TODO: More floaterm options; investigate spawning more than one and switching between them
