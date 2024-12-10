return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    lazy = true,
    config = function()
      -- This is where you modify the settings for lsp-zero
      -- Note: autocompletion settings will not take effect

      require("lsp-zero.settings").preset({})
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "L3MON4D3/LuaSnip" },
    },
    config = function()
      -- Here is where you configure the autocompletion settings.
      -- The arguments for .extend() have the same shape as `manage_nvim_cmp`:
      -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/api-reference.md#manage_nvim_cmp

      require("lsp-zero.cmp").extend()

      -- And you can configure cmp even more, if you want to.
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local cmp_action = require("lsp-zero.cmp").action()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-]>"] = cmp_action.luasnip_jump_forward(),
          ["<C-[>"] = cmp_action.luasnip_jump_backward(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }
      })
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    cmd = "LspInfo",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp", "lukas-reineke/lsp-format.nvim" },
    },
    config = function()
      local lsp = require("lsp-zero")

      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({buffer = bufnr})
        --lsp.buffer_autoformat()
      end)

      -- Configure all servers here.
      local lspconfig = require('lspconfig')
      lspconfig.gopls.setup({
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            ["local"] = "repo",
            gofumpt = true,
            analyses = {
              unusedparams = true,
            },
          },
        },
      })
      lspconfig.terraformls.setup({})
      vim.api.nvim_create_autocmd({"BufWritePre"}, {
        pattern = {"*.tf", "*.tfvars"},
        callback = function()
          vim.lsp.buf.format()
        end,
      })
      -- lspconfig.yamlls.setup({})
      lspconfig.bashls.setup({})
      lspconfig.pylsp.setup({})
      lspconfig.ts_ls.setup({})
      lspconfig.buf_ls.setup({})
      lspconfig.rust_analyzer.setup({
        settings = {
          ["rust-analyzer"] = {
            ["cargo"] = {
                ["loadOutDirsFromCheck"] = true
            },
            ["procMacro"] = {
                enable = true
            },
            ["checkOnSave"] = {
                enable = true
            },
            ["completion"] = {
                enableAutoimport = true
            },
            ["inlayHints"] = {
                typeHints = true
            },
            ["cargo-watch"] = {
                enable = true
            },
            workspace = {
              symbol = {
                search = {
                  kind = "all_symbols"
                }
              }
            }
          },
        }
      })

      local languages = require('efmls-configs.defaults').languages()

      lspconfig.efm.setup({
        filetypes = vim.tbl_keys(languages),
        on_attach = require("lsp-format").on_attach,
        settings = {
          rootMarkers = { '.git/' },
          languages = languages,
        },
        init_options = {
          documentFormatting = true,
          documentRangeFormatting = true,
        },
      })

      lsp.setup()
    end,
  },
  "ChiliConSql/neovim-stylus",
  "kblin/vim-fountain",
  "hashivim/vim-terraform",
  "simrat39/rust-tools.nvim",
  "mfussenegger/nvim-dap",
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "go", "gomod", "gosum", "graphql", "html", "json", "lua", "python", "rust", "sql", "typescript",
                              "dockerfile", "javascript", "perl", "ocaml", "make", "markdown", "scala", "yaml" },
        highlight = {
          enable = true
        }
      })
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    opts = {},
    build = ':lua require("go.install").update_all_sync()',
    config = function ()
      require("go").setup()

      -- Run gofmt + goimports on save
      local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
         require('go.format').goimports()
        end,
        group = format_sync_grp,
      })
    end
  },
  {
    "cuducos/yaml.nvim",
    ft = { "yaml" }, -- optional
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
    },
  },
  {
    'creativenull/efmls-configs-nvim',
    version = 'v1.x.x', -- version is optional, but recommended
    dependencies = { 'neovim/nvim-lspconfig' },
  },
  {
    'varnishcache-friends/vim-varnish'
  }
}
