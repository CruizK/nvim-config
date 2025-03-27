vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.g.nobackup = true

require("config.keymaps")
require("config.options")
require("config.autocmd")
require("config.lazy")
require("config.diagnostics")
