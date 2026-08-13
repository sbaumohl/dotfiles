local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- set map leader
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true          -- use spaces instead of tabs
vim.opt.relativenumber = true     -- relative line numbers
vim.opt.number = true
vim.opt.showmode = false          -- let lualine show status
vim.o.ignorecase = true           -- ignore case on search
vim.o.swapfile = false
vim.opt.undofile = true           -- persistent undo history
vim.opt.clipboard = "unnamedplus" -- use system clipboard
vim.opt.termguicolors = true      -- true color support

-- import plugin lists
local ui_plugins = require("plugins.ui")
local completion_plugins = require("plugins.completion")
local editor_plugins = require("plugins.editor")
local lsp_plugins = require("plugins.lsp")
local ts_plugins = require("plugins.treesitter")
local lazy_plugins = {}

-- take plugin lists from individual plugin/*.lua files,
-- and merge them for the Lazy plugin setup
for _, plugin_group in ipairs({ ui_plugins, completion_plugins, editor_plugins, lsp_plugins, ts_plugins }) do
    for _, plugin in ipairs(plugin_group) do
        table.insert(lazy_plugins, plugin)
    end
end

require("lazy").setup(lazy_plugins)

-- import my own custom lua files
require("ahhh")
