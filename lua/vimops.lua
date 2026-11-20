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

-- Python: indent bracket contents by one level and put the closing bracket
-- back under the line that opened it (the defaults double-indent both).
vim.g.python_indent = {
    open_paren = "shiftwidth()",
    nested_paren = "shiftwidth()",
    continue = "shiftwidth()",
    closed_paren_align_last_line = false,
}
