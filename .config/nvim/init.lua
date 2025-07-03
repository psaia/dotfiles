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

-- customize the diagnostic window a bit
vim.diagnostic.config({
    virtual_text = false,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = false,
})

-- some fundamental mappings to make life better for me
vim.g.mapleader = ','

require("lazy").setup("plugins")


vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamed"
vim.opt.colorcolumn = "+0"

vim.opt.fillchars = { fold = " " }
vim.opt.foldmethod = "indent"
vim.opt.foldenable = false
vim.opt.foldlevel = 99

vim.api.nvim_set_keymap('n', 'tn', ':tabnew<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'tl', ':tabprev<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'th', ':tabnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'td', ':tabclose<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Space>', 'za', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>cc', ':CodeCompanionChat Toggle<CR>', { noremap = true, silent = true })

-- make diagnostic window more accessible
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
