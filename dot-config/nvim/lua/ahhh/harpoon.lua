local harpoon_ui = require("harpoon.ui")
local harpoon_term = require("harpoon.term")
local harpoon_mark = require("harpoon.mark")

-- Harpoon ReadMe here: https://github.com/ThePrimeagen/harpoon?tab=readme-ov-file

-- Terminal navigation
vim.keymap.set("n", "<leader>ht", function()
	harpoon_term.gotoTerminal(1)
end, { noremap = true, silent = false })

-- Buffer Management
vim.keymap.set("n", "<leader>a", harpoon_mark.add_file)
vim.keymap.set("n", "<leader>e", harpoon_ui.toggle_quick_menu)

-- Cycling
vim.keymap.set("n", "<leader>hj", function()
	harpoon_ui.nav_next()
end, { noremap = true, silent = false })

vim.keymap.set("n", "<leader>hk", function()
	harpoon_ui.nav_prev()
end, { noremap = true, silent = false })
