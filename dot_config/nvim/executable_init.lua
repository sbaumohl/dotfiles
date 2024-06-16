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
	-- nvim-neorg notetaking plugin
	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		config = true,
	},
	{
		"nvim-neorg/neorg",
		dependencies = { "luarocks.nvim" },
		lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
		version = "8.7.1",
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {}
				}
			})
		end,
	},
	-- mason lsp install manager
	{
		"williamboman/mason.nvim",
	},
	-- tokyonight themes
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		priority = 1000,
		opts = {
			ensure_installed = { "c", "rust" },
			highlight = {
				enable = true,
			},
		},
	},
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
	{
		"m-demare/hlargs.nvim",
	},
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
	{ "mhartington/formatter.nvim" },
	{ "ckipp01/stylua-nvim" },
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			-- configurations go here
		},
	},
	{
		"lervag/vimtex", -- latex plugin
		lazy = false, -- we don't want to lazy load VimTeX
		init = function()
			-- VimTeX configuration goes here, e.g.
			vim.g.vimtex_view_method = "zathura"
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
}, {
	dev = {
		path = "~/.local/share/nvim/nix",
		fallback = false,
	},
})

-- tokyonight colorscheme
vim.cmd([[colorscheme tokyonight-night]])

-- set map leader
vim.g.mapleader = " "

-- relative line numbers
vim.wo.relativenumber = true

require("mason").setup()

-- comment default mappings
require("Comment").setup()

-- import my own custom lua files
require("ahhh")

-- git signs
require("gitsigns").setup()

-- finally, enable neorg
require("neorg").setup({
	load = {
		["core.neorg.dirman"] = {
			config = {
				workspaces = {
					notes = "~/notes",
				},
			},
		},
	},
})
