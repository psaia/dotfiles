return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "L3MON4D3/LuaSnip" },
    },
    config = function()
      -- And you can configure cmp even more, if you want to.
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
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
      -- Configure all servers here.
      local lspconfig = require('lspconfig')

      -- Add cmp_nvim_lsp capabilities settings to lspconfig
      -- This should be executed before you configure any language server
      local lspconfig_defaults = lspconfig.util.default_config
      lspconfig_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lspconfig_defaults.capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )

      -- This is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = {buffer = event.buf}

          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
          vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
          vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        end,
      })

      -- Configure language servers.
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

      -- Enable efm-language-server
      local eslint = require("efmls-configs.linters.eslint")
      local black = require("efmls-configs.formatters.black")
      local flake8 = require("efmls-configs.linters.flake8")
      local shfmt = require("efmls-configs.formatters.shfmt")
      local shellcheck = require("efmls-configs.linters.shellcheck")
      local prettier = require("efmls-configs.formatters.prettier")
      local markdown = require("efmls-configs.linters.markdownlint")

      lspconfig.efm.setup({
        on_attach = require("lsp-format").on_attach,
        settings = {
            rootMarkers = { ".git/" },
            languages = {
                sh = { shellcheck, shfmt },
                python = { black, flake8 },
                css = { prettier },
                html = { prettier },
                json = { eslint },
                markdown = { markdown },
                -- yaml = { prettier },
            },
        },
        filetypes = {
          "css",
          "sh",
          "html",
          "python",
          "json",
          "markdown",
          -- "yaml"
        },
        init_options = {
          documentFormatting = true,
          documentRangeFormatting = true,
          hover = true,
          documentSymbol = true,
          codeAction = true,
          completion = true,
        },
      })
    end,
  },
  "ChiliConSql/neovim-stylus",
  "kblin/vim-fountain",
  "hashivim/vim-terraform",
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
    dependencies = { 'neovim/nvim-lspconfig' },
  },
  {
    'varnishcache-friends/vim-varnish'
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false, -- This plugin is already lazy
  }
}
