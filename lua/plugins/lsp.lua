return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'saghen/blink.cmp',
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
                ensure_installed = { "lua_ls", "clangd" }
            }
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            require("lspconfig").lua_ls.setup { capabilities = capabilities }
            require("lspconfig").clangd.setup { capabilities = capabilities }


            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),

                callback = function(args)
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

                    if client.name == 'clangd' then
                        map('<leader>o', function()
                            vim.cmd('ClangdSwitchSourceHeader')
                        end, "Switch Header")
                    end


                    -- Setup auto format on save
                    if client.supports_method('textDocument/formatting') then
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            buffer = args.buf,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                            end
                        })
                    end
                end
            })
        end
    }
}
