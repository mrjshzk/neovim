local map = vim.keymap.set

map("n", "<space>", "<Nop>")

map("i", "jk", "<Esc>")
map("i", "kj", "<Esc>")

map("n", "lf", ":lua vim.lsp.buf.format()<Cr>")
map("n", "<leader>gg", ":Neogit<Cr>")
