require("telescope").setup({
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- "smart_case" | "ignore_case" | "respect_case"
		},
	},
})

-- load the native fzf sorter (compiled C) so fuzzy matching is fast
require("telescope").load_extension("fzf")

-- show fidget notification history in telescope
require("telescope").load_extension("fidget")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>fa", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>ff", builtin.git_files, {})
