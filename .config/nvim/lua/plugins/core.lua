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
    "junegunn/fzf",
    "junegunn/fzf.vim",
    config = function()
      require("fzf").install()
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
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
      require("telescope").setup({
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

      require("telescope").load_extension("file_browser")
    end,
  },
}
