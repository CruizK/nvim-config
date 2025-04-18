vim.keymap.set('n', '<leader>cmg', ':CMakeGenerate<CR>', { desc = "[CM]ake [G]enerate" })
vim.keymap.set('n', '<leader>cmr', ':CMakeRun<CR>', { desc = "[CM]ake [R]un" })
vim.keymap.set('n', '<leader>cmb', ':CMakeBuild<CR>', { desc = "[CM]ake [B]uild" })
vim.keymap.set('n', '<leader>cmd', ':CMakeDebug<CR>', { desc = "[CM]ake [D]ebug" })
vim.keymap.set('v', '<leader>dcf', ":'<,'>TSCppDefineClassFunc<CR>", { desc = "[D]efine [C]lass [F]unc" })
