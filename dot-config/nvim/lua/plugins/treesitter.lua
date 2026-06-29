return {
	"rebelot/kanagawa.nvim", -- not a default right now, but I like to keep it around
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			vim.cmd.colorscheme("tokyonight")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		priority = 1000,
		config = function()
			require('nvim-treesitter').install({
				"bash",
				"c",
				"cpp",
				"css",
				"diff",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"rust",
				"python",
				"typescript",
				"latex",
				"xml",
				"yaml",
				"markdown",
				"markdown_inline",
				"html",
				"lua",
				"regex",
				"typst",
				"svelte",
			})

			-- must be started per-buffer. Enable TS highlighting for any
			-- filetype that has an installed parser
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
		end
	},
	{
		'nvim-telescope/telescope.nvim',
		version = '*',
		dependencies = {
			'nvim-lua/plenary.nvim',
			-- optional but recommended
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		}
	},
}
