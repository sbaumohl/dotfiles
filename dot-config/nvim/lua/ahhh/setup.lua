-- lua line
require("lualine").setup({})

-- lsp manager
require("mason").setup()
require("mason-tool-installer").setup({
	ensure_installed = { "shellcheck", "markdownlint" },
})

-- comment default mappings
require("Comment").setup()

-- git signs
require("gitsigns").setup()

-- buffer movement (barbar)
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
-- Re-order to previous/next
map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
-- Goto buffer in position...
map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)

-- Close buffer
map("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)

-- nvim tree
local NvimTreeAPI = require("nvim-tree.api")
vim.keymap.set("n", "<leader>to", ":NvimTreeOpen<CR>")
vim.keymap.set("n", "<leader>tc", NvimTreeAPI.tree.close)
vim.keymap.set("n", "<leader>tf", function()
	-- update_root so it still works when the buffer lives outside the tree root
	NvimTreeAPI.tree.find_file({ open = true, focus = true, update_root = true })
end, { desc = "Reveal Buffer in NvimTree" })

-- undo tree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Persistence (session restore)
vim.keymap.set("n", "<leader>qs", function()
	require("persistence").load()
end, { desc = "Restore Session" })

-- which-key labels for keymaps defined elsewhere (telescope.lua / above).
-- Pure descriptions, not mappings. Keys whose keymap already sets `desc`
-- (e.g. <leader>qs) are omitted since which-key reads that automatically.
local wk = require("which-key")
wk.add({
	{ "<leader>ff", desc = "Search Git Files", mode = "n" },
	{ "<leader>fb", desc = "Find Buffer",      mode = "n" },
	{ "<leader>fg", desc = "Live Grep",        mode = "n" },
	{ "<leader>fa", desc = "Search All Files", mode = "n" },
	{ "<leader>tc", desc = "Close NvimTree",   mode = "n" },
	{ "<leader>u",  desc = "Open Undotree",    mode = "n" },
})

require("hlargs").setup({})
