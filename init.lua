-- leader key (must be before plugins)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- basic sanity
vim.opt.number = true
vim.opt.relativenumber = true

require("config.lazy")
require("config.lsp")
require("config.telescope")
require("config.treesitter")
require("config.diagnostics")
require("config.filetree")

require("config.options")
require("config.keymaps")
require("config.autocmds")
