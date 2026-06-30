-- here you can setup the language servers
local capabilities = require('blink.cmp').get_lsp_capabilities()
vim.lsp.config("*", { capabilities = capabilities })

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
	}
})

-- astro-ls requires a typescript SDK; use the one bundled with the mason
-- astro-language-server install so it works outside a node project too.
vim.lsp.config("astro", {
	init_options = {
		typescript = {
			tsdk = vim.fn.stdpath("data")
				.. "/mason/packages/astro-language-server/node_modules/typescript/lib",
		},
	},
})
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
	}
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			workspace = {
				checkThirdParty = false,
				library = vim.api.nvim_get_runtime_file("", true),
			},
			diagnostics = { globals = { "vim" } },
			telemetry = { enable = false },
		}
	}
})

vim.lsp.enable(
	{ "lua_ls", "astro", "eslint", "dockerls", "clangd", "svelte", "ty", "ruff", "texlab", "cmake", "glsl_analyzer" }
)

vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

vim.diagnostic.config({
	virtual_text = { current_line = true },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = '',
			[vim.diagnostic.severity.WARN] = '',
			[vim.diagnostic.severity.HINT] = '',
			[vim.diagnostic.severity.INFO] = ' ',
		},
	},
})
-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 500
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false })
	end,
})

require("lsp-endhints").setup({
	icons = {
		type = "󰜁 ",
		parameter = "󰏪 ",
		offspec = " ", -- hint kind not defined in official LSP spec
		unknown = " ", -- hint kind is nil
	},
	label = {
		truncateAtChars = 20,
		padding = 1,
		marginLeft = 0,
		sameKindSeparator = ", ",
	},
	extmark = {
		priority = 50,
	},
	autoEnableHints = true,
})
