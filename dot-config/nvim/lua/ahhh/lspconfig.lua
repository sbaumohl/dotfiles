-- here you can setup the language servers
local capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

vim.lsp.config("clangd", {
	cmd = {
		-- see clangd --help-hidden
		"clangd",
		"--background-index",
		-- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
		-- to add more checks, create .clang-tidy file in the root directory
		-- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
		"--clang-tidy",
		"--completion-style=bundled",
		"--cross-file-rename",
		"--header-insertion=iwyu",
	},
	init_options = {
		fallbackFlags = { "--std=c++20" },
	},
	capabilities = capabilities,
})

vim.lsp.config("cmake", { capabilities = capabilities })
vim.lsp.config("dockerls", { capabilities = capabilities })

vim.lsp.config("astro", { capabilities = capabilities })
vim.lsp.config("texlab", {
	settings = {
		texlab = {
			auxDirectory = "build",
			bibtexFormatter = "texlab",
			build = {
				args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
				executable = "latexmk",
				forwardSearchAfter = false,
				onSave = false,
			},
			chktex = {
				onEdit = false,
				onOpenAndSave = false,
			},
			diagnosticsDelay = 300,
			formatterLineLength = 80,
			forwardSearch = {
				args = {},
			},
			latexFormatter = "latexindent",
			latexindent = {
				modifyLineBreaks = false,
			},
		},
	},
})

vim.lsp.config("eslint", {
	settings = {
		enable = true,
	},
	capabilities = capabilities
})

vim.lsp.config("svelte", {
	capabilities = capabilities
})
vim.lsp.config('ruff', {
	capabilities = capabilities
})

vim.lsp.enable({ "astro", "eslint", "dockerls", "clangd", "svelte", "ty", "ruff", "texlab", "cmake" })

vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
	virtual_text = false,
})
-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 500
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  callback = function()
	  vim.diagnostic.open_float(nil, { focus = false })
  end,
})
