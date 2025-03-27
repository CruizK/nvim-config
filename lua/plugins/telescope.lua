return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  config = function()
    -- We can put paths to ignore here
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

    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind [G]rep" })
    vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostic" })
    vim.keymap.set("n", "<leader>fc", function()
      builtin.find_files { cwd = vim.fn.stdpath('config') }
    end, { desc = "[F]ind [C]onfig" })
    vim.keymap.set("n", "<leader>fnd", function()
      builtin.find_files { cwd = vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy') }
    end, { desc = "[F]ind [N]eovim [D]ata" })
  end


}
