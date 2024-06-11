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

-- require("sbaumohl")
require("lazy").setup({
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
		opts = {},
	},
	{
		"nvim-tree/nvim-tree.lua",
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

	-- harpoon
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
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {
			-- configurations go here
		},
	},
	{
  		"lervag/vimtex",  -- latex plugin
  		lazy = false,     -- we don't want to lazy load VimTeX
  		init = function()
    			-- VimTeX configuration goes here, e.g.
    			vim.g.vimtex_view_method = "zathura"
  		end
	}
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

-- comment default mappings
require("mason").setup()
require("Comment").setup()
require("ahhh")
