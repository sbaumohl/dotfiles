return {
	{
		"chrisgrieser/nvim-lsp-endhints",
		event = "LspAttach",
		opts = {}, -- required, even if empty
	},
	-- mason lsp install manager
	"mason-org/mason.nvim",
	{
		"neovim/nvim-lspconfig",
		-- opts = {
		-- 	inlay_hints = { enabled = true },
		-- },
	},
	"onsails/lspkind-nvim",
	"mfussenegger/nvim-lint",
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
		config = function()
			require("typescript-tools").setup({
				on_attach = function(client, bufnr)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end,
				settings = {
					jsx_close_tag = {
						enable = true,
						filetypes = { "javascriptreact", "typescriptreact" },
					},
				},
			})
		end,
	},
	"whonore/Coqtail",
	"tomtomjhj/coq-lsp.nvim",
	{
		"ms-jpq/coq_nvim",
	},
}
