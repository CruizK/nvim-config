return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'saghen/blink.cmp',
      'Hoffs/omnisharp-extended-lsp.nvim',
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls", "clangd", "pyright" },
        automatic_installation = false
      }
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      require("lspconfig").lua_ls.setup { capabilities = capabilities }
      require("lspconfig").clangd.setup { capabilities = capabilities }
      require("lspconfig").pyright.setup { capabilities = capabilities }
      vim.g.zig_fmt_parse_errors = 0
      vim.g.zig_fmt_autosave = 0
      require("lspconfig").zls.setup {
        capabilities = capabilities,
        settings = {
          zls = {
            enable_build_on_save = true,
            build_on_save_step = "check"
          }
        }
      }

      -- Only setup on windows machine
      if vim.fn.has("win32") then
        require("config.plugins.lsp").omnisharp_setup(capabilities)
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = require("config.plugins.lsp").on_attach
      })
    end
  }
}
