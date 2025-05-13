return {
	{ "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
	{
		"chrisgrieser/nvim-lsp-endhints",
		event = "LspAttach",
		opts = {}, -- required, even if empty
	},
	-- mason lsp install manager
	"williamboman/mason.nvim",
	"neovim/nvim-lspconfig",
	"onsails/lspkind-nvim",
	"mfussenegger/nvim-lint",
}
