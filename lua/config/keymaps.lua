local set = vim.keymap.set

set('i', '<C-c>', '<Esc>')
set('i', '<Left>', '<Nop>')
set('i', '<Right>', '<Nop>')
set('i', '<Up>', '<Nop>')
set('i', '<Down>', '<Nop>')


set('n', '<M-j>', '<cmd>cnext<CR>')
set('n', '<M-k>', '<cmd>cprev<CR>')

set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Move selection up and down
set('v', 'K', ":m '<-2<CR>gv=gv", { desc = "Move selected line up" })
set('v', 'J', ":m '>+1<CR>gv=gv", { desc = "Move selected line down" })

set('v', '<Tab>', '>gv', { desc = "Indent selection" })
set('v', '<S-Tab>', '<gv', { desc = "De-Indent selection " })

-- Window movement
set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
set('n', '<C-f>', "<cmd>silent !tmux neww tmux-sessionizer<CR>")
