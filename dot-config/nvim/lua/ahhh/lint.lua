-- linters for filetypes not already covered by an LSP in lspconfig.lua
require("lint").linters_by_ft = {
	sh = { "shellcheck" },
	bash = { "shellcheck" },
	markdown = { "markdownlint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
