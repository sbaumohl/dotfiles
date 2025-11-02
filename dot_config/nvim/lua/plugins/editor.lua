return {
	"mbbill/undotree",
	-- harpoon - switch between buffers and terminal
	"ThePrimeagen/harpoon",
	"m-demare/hlargs.nvim",
	-- mass commenting
	{
		"numToStr/Comment.nvim",
		lazy = false,
	},
	{
		"tpope/vim-surround",
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	-- conform does format on saving and allows language specific configs
	{
		"stevearc/conform.nvim",
		opts = {},
	},
	{
		"greggh/claude-code.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim", -- Required for git operations
		},
		config = function()
			require("claude-code").setup()
		end,
	},
}
