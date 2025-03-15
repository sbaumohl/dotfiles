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

require("lazy").setup({
	-- conform does format on saving and allows language specific configs
	{
		"stevearc/conform.nvim",
		opts = {},
	},
	-- mason lsp install manager
	{ "williamboman/mason.nvim" },

	-- tree-sitter theme
	{
		"rebelot/kanagawa.nvim",
		config = function()
			vim.cmd.colorscheme("kanagawa")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		priority = 1000,
		opts = {
			ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "rust", "python", "typescript", "latex" },
			ignore_install = { "org" },
			highlight = {
				enable = true,
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{ "nvim-treesitter/nvim-treesitter-textobjects", event = "InsertEnter" },
	{
		"nvim-tree/nvim-tree.lua", -- file explorer
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({})
		end,
	},
	{ "m-demare/hlargs.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" },
	},

	{ "neovim/nvim-lspconfig" },
	-- completions
	{ "hrsh7th/cmp-nvim-lsp-signature-help" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-nvim-lua" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-vsnip" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/vim-vsnip" },

	-- lsp-zero
	{ "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
	{ "neovim/nvim-lspconfig" },
	{ "L3MON4D3/LuaSnip" },

	-- harpoon - switch between buffers and terminal
	{ "ThePrimeagen/harpoon" },

	-- mass commenting
	{
		"numToStr/Comment.nvim",
		lazy = false,
	},
	{ "saadparwaiz1/cmp_luasnip" },
	{ "onsails/lspkind-nvim" },
	{ "mfussenegger/nvim-lint" },
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
		"romgrk/barbar.nvim", -- tabline
		dependencies = {
			"lewis6991/gitsigns.nvim", -- for git status
			"nvim-tree/nvim-web-devicons", -- for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			-- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
			-- animation = true,
			-- insert_at_start = true,
			-- …etc.
		},
		version = "^1.0.0", -- optional: only update when a new 1.x version is released
	},
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	{ "mbbill/undotree" },
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
	{
		"chrisgrieser/nvim-lsp-endhints",
		event = "LspAttach",
		opts = {}, -- required, even if empty
	},
	{
		"jbyuki/nabla.nvim",
	},
	{
		"tpope/vim-surround",
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
	},
})

vim.g.mapleader = " " -- set map leader
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.wo.relativenumber = true -- relative line numbers
vim.wo.number = true
vim.opt.showmode = false -- let lualine show status
vim.o.ignorecase = true -- ignore case on search

-- undotree toggle
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- nvim file tree
local NvimTreeAPI = require("nvim-tree.api")
-- local NvimTreeTree = require("nvim-tree.tree")
vim.keymap.set("n", "<leader>to", ":NvimTreeOpen<CR>")
vim.keymap.set("n", "<leader>tc", NvimTreeAPI.tree.close)

-- barbar tabline plugin for dealing with tabs
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
-- Re-order to previous/next
map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
-- Goto buffer in position...
map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)

-- Close buffer
map("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)

-- lsp manager
require("mason").setup()

-- comment default mappings
require("Comment").setup()

-- import my own custom lua files
require("ahhh")

-- git signs
require("gitsigns").setup()

-- lua line
require("lualine").setup()

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
