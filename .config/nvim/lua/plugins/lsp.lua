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

  -- LSP (Native Neovim 0.11+ API)
  {
    "hrsh7th/cmp-nvim-lsp",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "lukas-reineke/lsp-format.nvim",
      "creativenull/efmls-configs-nvim",
    },
    config = function()
      -- Global capabilities for all LSP servers
      vim.lsp.config('*', {
        capabilities = vim.tbl_deep_extend(
          'force',
          vim.lsp.protocol.make_client_capabilities(),
          require('cmp_nvim_lsp').default_capabilities()
        )
      })

      -- LSP keybindings on attach
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

          -- Handle lsp-format for EFM
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.name == 'efm' then
            require("lsp-format").on_attach(client)
          end
        end,
      })

      -- Terraform format-on-save
      vim.api.nvim_create_autocmd({"BufWritePre"}, {
        pattern = {"*.tf", "*.tfvars"},
        callback = function()
          vim.lsp.buf.format()
        end,
      })

      -- Configure language servers
      vim.lsp.config('gopls', {
        cmd = { 'gopls' },
        filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
        root_markers = { 'go.work', 'go.mod', '.git' },
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

      vim.lsp.config('terraformls', {
        cmd = { 'terraform-ls', 'serve' },
        filetypes = { 'terraform', 'terraform-vars', 'tf' },
        root_markers = { '.terraform', '.git' },
      })

      vim.lsp.config('bashls', {
        cmd = { 'bash-language-server', 'start' },
        filetypes = { 'sh', 'bash' },
        root_markers = { '.git' },
      })

      vim.lsp.config('pylsp', {
        cmd = { 'pylsp' },
        filetypes = { 'python' },
        root_markers = { 'pyproject.toml', 'setup.py', 'requirements.txt', '.git' },
      })

      vim.lsp.config('ts_ls', {
        cmd = { 'typescript-language-server', '--stdio' },
        filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
        root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
      })

      vim.lsp.config('buf_ls', {
        cmd = { 'buf', 'beta', 'lsp' },
        filetypes = { 'proto' },
        root_markers = { 'buf.yaml', '.git' },
      })

      -- EFM language server (formatters/linters)
      local eslint = require("efmls-configs.linters.eslint")
      local black = require("efmls-configs.formatters.black")
      local flake8 = require("efmls-configs.linters.flake8")
      local shfmt = require("efmls-configs.formatters.shfmt")
      local shellcheck = require("efmls-configs.linters.shellcheck")
      local prettier = require("efmls-configs.formatters.prettier")
      local markdown = require("efmls-configs.linters.markdownlint")

      vim.lsp.config('efm', {
        cmd = { 'efm-langserver' },
        filetypes = { 'css', 'sh', 'html', 'python', 'json', 'markdown' },
        root_markers = { '.git' },
        init_options = {
          documentFormatting = true,
          documentRangeFormatting = true,
          hover = true,
          documentSymbol = true,
          codeAction = true,
          completion = true,
        },
        settings = {
          rootMarkers = { '.git/' },
          languages = {
            sh = { shellcheck, shfmt },
            python = { black, flake8 },
            css = { prettier },
            html = { prettier },
            json = { eslint },
            markdown = { markdown },
          },
        },
      })

      -- Enable all language servers
      vim.lsp.enable({
        'gopls',
        'terraformls',
        'bashls',
        'pylsp',
        'ts_ls',
        'buf_ls',
        'efm',
      })
    end,
  },
  "iloginow/vim-stylus",
  "kblin/vim-fountain",
  "hashivim/vim-terraform",
  "mfussenegger/nvim-dap",
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- the main branch does not support lazy-loading
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup()

      -- Install the parsers we use (async; skips already-installed ones).
      -- markdown_inline is required for markdown highlighting to work.
      require("nvim-treesitter").install({
        "go", "gomod", "gosum", "graphql", "html", "json", "lua", "python",
        "rust", "sql", "typescript", "dockerfile", "javascript", "perl",
        "ocaml", "make", "markdown", "markdown_inline", "scala", "yaml",
      })

      -- On the main branch the old `configs.setup({ highlight = { enable } })`
      -- module is gone -- you start highlighting/indentation yourself.
      -- Start treesitter for any buffer whose filetype has a parser available.
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local buf = args.buf
          local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
          if not lang then
            return
          end
          if not pcall(vim.treesitter.start, buf, lang) then
            return -- parser not installed yet; will work once :TSUpdate finishes
          end
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
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
    'varnishcache-friends/vim-varnish'
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false, -- This plugin is already lazy
  }
}
