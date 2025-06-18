-- here you can setup the language servers
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

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
	capabilities = capabilities,
})

vim.lsp.config("cmake", { capabilities = capabilities })
vim.lsp.config("dockerls", { capabilities = capabilities })
vim.lsp.config("pyright", {
	capabilities = capabilities,
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "on",
			},
		},
	},
})

vim.lsp.config("astro", {})
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
		enable = false,
	},
})

vim.lsp.enable({ "astro", "pyright", "eslint", "dockerls", "clangd" })

-- require("typescript-tools").setup({})

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
vim.cmd([[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])

-- enable endline hints now that lsp is enabled
require("lsp-endhints").enable()
