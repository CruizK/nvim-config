return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
        local ignore_patterns = { 'deps/' }
        if require('config.os').iswin32 then
            for i, pattern in pairs(ignore_patterns) do
                ignore_patterns[i] = pattern:gsub("/", "\\")
            end
        end
        require('telescope').setup {
            defaults = {
                file_ignore_patterns = ignore_patterns
            },
            pickers = {
                find_files = {
                    theme = "ivy"
                }
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = 'smart_case'
                }
            }
        }
        require('telescope').load_extension('fzf')
        local builtin = require("telescope.builtin")

        vim.keymap.set("n", "<leader>fh", builtin.help_tags)
        vim.keymap.set("n", "<leader>ff", builtin.find_files)
        vim.keymap.set("n", "<leader>fg", builtin.live_grep)
        vim.keymap.set("n", "<leader>fd", builtin.diagnostics)
        vim.keymap.set("n", "<leader>fc", function()
            builtin.find_files { cwd = vim.fn.stdpath('config') }
        end)
        vim.keymap.set("n", "<leader>fnd", function()
            builtin.find_files { cwd = vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy') }
        end)
    end


}
