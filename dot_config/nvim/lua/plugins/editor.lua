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
}
