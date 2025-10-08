return {
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
			ensure_installed = {
				"bash",
				"c",
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
			},
			highlight = { enable = true },
			indent = { enable = true },
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{ "nvim-treesitter/nvim-treesitter-textobjects", event = "InsertEnter" },
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" },
	},
	{
		"folke/which-key.nvim",
		opts = {
			spec = {
				{ "<BS>", desc = "Decrement Selection", mode = "x" },
				{ "<c-space>", desc = "Increment Selection", mode = { "x", "n" } },
			},
		},
	},
}
