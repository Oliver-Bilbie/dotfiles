vim.loader.enable()

local core_conf_files = {
	"globals.lua", -- some global settings
	"options.vim", -- setting options in nvim
	"autocommands.vim", -- various autocommands
	"mappings.lua", -- all the user-defined mappings
	"plugins.vim", -- all the plugins installed and their configurations
}

-- source all the core config files
for _, file_name in ipairs(core_conf_files) do
	if vim.endswith(file_name, "vim") then
		local path = string.format("%s/core/%s", vim.fn.stdpath("config"), file_name)
		local source_cmd = "source " .. path
		vim.cmd(source_cmd)
	else
		local module_name, _ = string.gsub(file_name, "%.lua", "")
		package.loaded[module_name] = nil
		require(module_name)
	end
end

-- Set the colorscheme based on the time
local current_hour = tonumber(os.date("%H"))
if current_hour > 7 and current_hour < 17 then
	vim.cmd([[colorscheme tokyonight]])
else
	vim.cmd([[colorscheme tokyonight-night]])
end
