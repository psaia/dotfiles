return {
  {
    "navarasu/onedark.nvim",
    config = function()
      require('onedark').setup {
        style = 'warm',
        toggle_style_key = "<leader>ts",
      }
      require("onedark").load()
    end,
  },
  "tpope/vim-sleuth",
  "tpope/vim-fugitive",
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        sections = {
          lualine_a = {
            {
              'filename',
              file_status = true,      -- Displays file status (readonly status, modified status)
              newfile_status = false,  -- Display new file status (new file means no write after created)
              path = 1,                -- 0: Just the filename
                                       -- 1: Relative path
                                       -- 2: Absolute path
                                       -- 3: Absolute path, with tilde as the home directory
                                       -- 4: Filename and parent dir, with tilde as the home directory

              shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
                                       -- for other components. (terrible name, any suggestions?)
              symbols = {
                modified = '[+]',      -- Text to show when the file is modified.
                readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
                unnamed = '[No Name]', -- Text to show for unnamed buffers.
                newfile = '[New]',     -- Text to show for newly created file before first write
              }
            }
          }
        },
        options = {
          theme = "onedark"
        },
      })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 40,
        },
        filters = {
          dotfiles = false,
        },
      })
      vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
    end
  },
  "nvim-lua/plenary.nvim",
  "direnv/direnv.vim",
  "editorconfig/editorconfig-vim",
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    config = function()
      local ts = require("telescope")

      ts.setup({
        pickers = {
          live_grep = {
            additional_args = function(opts)
              return {"--hidden", "--glob", "!{**/.git/*,**/node_modules/*,**/package-lock.json,**/yarn.lock}"}
            end
          },
        },
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
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
}
