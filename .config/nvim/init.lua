local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
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

-- some fundamental mappings to make life better for me
vim.g.mapleader = ','

require("lazy").setup("plugins")

vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamed"
vim.opt.colorcolumn = "+0"

vim.api.nvim_set_keymap('n', 'tn', ':tabnew<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'tl', ':tabprev<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'th', ':tabnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'td', ':tabclose<CR>', { noremap = true, silent = true })

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

