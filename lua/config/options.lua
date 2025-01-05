if require('config.os').iswin32 then
    vim.opt.shell = 'pwsh'
    vim.opt.shellcmdflag = '-nologo -noprofile -ExecutionPolicy RemoteSigned -command'
    vim.opt.shellxquote = ''
end

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = 'a'

vim.opt.showmode = false

vim.opt.clipboard = 'unnamedplus'

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 250

vim.opt.splitright = true
vim.opt.splitbelow = true


vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 8

vim.opt.hlsearch = true
vim.opt.smartindent = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.pumheight = 10 -- limit completion items

if vim.g.neovide then
    vim.o.guifont = 'FiraCode Nerd Font:h12'
    vim.g.neovide_cursor_animation_length = 0.1
end
