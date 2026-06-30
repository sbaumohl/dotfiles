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
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require('nvim-ts-autotag').setup({
				opts = {
					-- Defaults
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = false -- Auto close on trailing </
				},
				-- Also override individual filetype configs, these take priority.
				-- Empty by default, useful if one of the "opts" global settings
				-- doesn't work well in a specific filetype
				per_filetype = {
					["html"] = {
						enable_close = false
					}
				}
			})
		end
	}
}
