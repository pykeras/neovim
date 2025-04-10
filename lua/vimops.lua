vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- vim.cmd("set number") alternative approach.
vim.opt.number = true
vim.opt.autoindent = true
vim.opt.spelllang = "en_us"
vim.opt.spell = true
vim.opt.autoread = true
vim.g.mapleader = " "

-- Cursor hold time reduce
vim.o.updatetime = 100
vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})]]
