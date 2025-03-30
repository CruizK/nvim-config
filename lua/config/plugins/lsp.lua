local M = {}

--- @param capabilities lsp.ClientCapabilities
M.omnisharp_setup = function(capabilities)
  local omnisharp_bin = "C:\\omnisharp\\OmniSharp.exe"
  local pid = vim.fn.getpid()
  require("lspconfig").omnisharp.setup {
    cmd = {
      omnisharp_bin,
      "--languageserver",
      "--hostPID",
      tostring(pid)
    },
    handlers = { ['textDocument/definition'] = require('omnisharp_extended').handler },
    capabilities = capabilities,
    settings = {
      FormattingOptions = {
        OrganizeImports = true
      },
      RoslynExtensionsOptions = {
        EnableAnalyzersSupport = true
      }
    }
  }
end

--- @param args vim.api.keyset.create_autocmd.callback_args
M.on_attach = function(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if not client then return end
  local map = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
  end

  map('gd', vim.lsp.buf.definition, "[G]oto [D]efinition")
  map('gr', vim.lsp.buf.references, "[G]oto [R]references")
  map('gi', vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  map('vrn', vim.lsp.buf.rename, "[v] [R]e [N]ame")
  map('vca', vim.lsp.buf.code_action, "[v] [C]ode [A]ction")
  map('<leader>sd', vim.diagnostic.open_float, "[Show] [Diagnostics]")
  map('K', vim.lsp.buf.hover, "Hover")

  -- This will highlight all instances of a symbol when you keep your cursor
  -- there for an extended preiod of time & then clear on move
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = args.buf,
      callback = vim.lsp.buf.document_highlight
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      buffer = args.buf,
      callback = vim.lsp.buf.clear_references
    })
  end

  -- Setup auto format on save
  if client:supports_method('textDocument/formatting', nil) then
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = args.buf,
      callback = function()
        vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
      end
    })
  end
end

return M
