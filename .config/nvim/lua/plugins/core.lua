return {
  {
    "navarasu/onedark.nvim",
    config = function()
      require('onedark').setup {
        style = 'warm'
      }
      require("onedark").load()
    end,
  },
  "tpope/vim-sleuth",
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = "onedark" },
      })
    end,
  },
  "nvim-lua/plenary.nvim",
  "direnv/direnv.vim",
  "editorconfig/editorconfig-vim",
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    config = function()
      local ts = require("telescope")

      ts.setup({
        extensions = {
          file_browser = {
            hijack_netrw = true,
          },
        },
      })

      -- open file_browser with the path of the current buffer
      vim.api.nvim_set_keymap(
        "n",
        "<space>fb",
        ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
        { noremap = true }
      )

      vim.api.nvim_set_keymap('n', '<space>ff', ':Telescope find_files<CR>', {})
      vim.api.nvim_set_keymap('n', '<space>fg', ':Telescope live_grep<CR>', {})
      vim.api.nvim_set_keymap('n', '<space>fh', ':Telescope help_tags<CR>', {})


      ts.load_extension("file_browser")
    end,
  },
}
