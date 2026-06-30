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
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "ruff", "isort", "black" },
				-- You can customize some of the format options for the filetype (:help conform.format)
				rust = { "rustfmt", lsp_format = "fallback" },
				-- Conform will run the first available formatter
				typescript = { "prettierd", "prettier" },
				typescriptreact = { "prettierd", "prettier" },
				javascript = { "prettierd", "prettier" },
				javascriptreact = { "prettierd", "prettier" },
				json = { "prettierd", "prettier" },
				html = { "prettier" },
				css = { "prettierd", "prettier" },
				tex = { "latexindent" },
				-- needs `prettier-plugin-astro` in the project (Astro starters include it)
				astro = { "prettierd", "prettier" },
			},
			format_on_save = function(bufnr)
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return -- skip formatting
				end
				return { timeout_ms = 500, lsp_format = "fallback" }
			end,
		},
	},
	{
		"lervag/vimtex", -- latex plugin
		lazy = false, -- we don't want to lazy load VimTeX
		init = function()
			-- VimTeX configuration goes here, e.g.
			vim.g.vimtex_view_method = "general"
			vim.g.vimtex_view_general_viewer = "okular"
			vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^9", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
	{
		"folke/which-key.nvim",
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		}
	},
	{
		"j-hui/fidget.nvim",
		opts = {
			-- options
		},
	}
}
