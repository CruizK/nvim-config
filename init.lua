vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.g.nobackup = true
vim.g.omni_sql_no_default_maps = 1

require("config.keymaps")
require("config.options")
require("config.autocmd")
require("config.lazy")
require("config.diagnostics")
