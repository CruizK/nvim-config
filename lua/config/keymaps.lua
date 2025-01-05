local set = vim.keymap.set



set('i', '<C-c>', '<Esc>')
set('i', '<Left>', '<Nop>')
set('i', '<Right>', '<Nop>')
set('i', '<Up>', '<Nop>')
set('i', '<Down>', '<Nop>')

-- Move selection up and down
set('v', 'J', ":m '>+1<CR>gv=gv")
set('v', 'K', ":m '<-2<CR>gv=gv")

-- Allows to tab in-out blocks
set('v', '<Tab>', '>gv')
set('v', '<S-Tab>', '<gv')

set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
