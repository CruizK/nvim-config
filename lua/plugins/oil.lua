return {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    config = function()
        require('oil').setup {
            keymaps = {
                ["<C-h>"] = false
            },
            view_options = {
                show_hidden = true
            }
        }

        vim.keymap.set('n', '<leader>pv', '<CMD>Oil<CR>', { desc = 'Open Oil' })
    end
}
