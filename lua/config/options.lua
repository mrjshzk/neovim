local opt = vim.opt

-- line numbers
opt.number = true
opt.relativenumber = true

-- indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

-- search
opt.ignorecase = true
opt.smartcase = true

-- UI / behavior
opt.cursorline = true
opt.signcolumn = "yes"
opt.wrap = false
opt.scrolloff = 8

-- clipboard (use system clipboard)
opt.clipboard = "unnamedplus"

-- faster updates
opt.updatetime = 250
opt.timeoutlen = 300

