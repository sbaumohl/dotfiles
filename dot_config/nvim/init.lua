local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- import plugin lists
local ui_plugins = require("plugins.ui")
local completion_plugins = require("plugins.completion")
local editor_plugins = require("plugins.editor")
local lsp_plugins = require("plugins.lsp")
local ts_plugins = require("plugins.treesitter")
local lazy_plugins = {
	{ "L3MON4D3/LuaSnip" },
	{ "ckipp01/stylua-nvim" },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"lervag/vimtex", -- latex plugin
		lazy = false, -- we don't want to lazy load VimTeX
		init = function()
			-- VimTeX configuration goes here, e.g.
			vim.g.vimtex_view_method = "general"
			vim.g.vimtex_view_general_viewer = "okular"
			vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
}

-- take plugin lists from individual plugin/*.lua files,
-- and merge them for the Lazy plugin setup
for _, plugin_group in ipairs({ ui_plugins, completion_plugins, editor_plugins, lsp_plugins, ts_plugins }) do
	for _, plugin in ipairs(plugin_group) do
		table.insert(lazy_plugins, plugin)
	end
end

require("lazy").setup(lazy_plugins)

vim.g.mapleader = " " -- set map leader
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.wo.relativenumber = true -- relative line numbers
vim.wo.number = true
vim.opt.showmode = false -- let lualine show status
vim.o.ignorecase = true -- ignore case on search
vim.o.swapfile = false

-- import my own custom lua files
require("ahhh")

-- rust ide setup
require("lsp-endhints").setup({
	icons = {
		type = "󰜁 ",
		parameter = "󰏪 ",
		offspec = " ", -- hint kind not defined in official LSP spec
		unknown = " ", -- hint kind is nil
	},
	label = {
		truncateAtChars = 20,
		padding = 1,
		marginLeft = 0,
		sameKindSeparator = ", ",
	},
	extmark = {
		priority = 50,
	},
	autoEnableHints = true,
})

local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set("n", "<leader>a", function()
	vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
	-- or vim.lsp.buf.codeAction() if you don't want grouping.
end, { silent = true, buffer = bufnr })
vim.keymap.set(
	"n",
	"K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
	function()
		vim.cmd.RustLsp({ "hover", "actions" })
	end,
	{ silent = true, buffer = bufnr }
)
