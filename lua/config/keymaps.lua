local map = vim.keymap.set

-- better escape
map("i", "jj", "<Esc>")
map("i", "jk", "<Esc>")

-- clear search highlight
map("n", "<leader>h", ":nohlsearch<CR>")

-- window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- resize splits
map("n", "<C-Up>", ":resize -2<CR>")
map("n", "<C-Down>", ":resize +2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")

-- Filetree keymaps
vim.keymap.set("n", "<leader>tf", "<CMD>NvimTreeToggle<CR>", { desc = "Toggle file tree" })

-- telescope keymaps
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Telescope old files" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fp", function()
	builtin.find_files({
		cwd = vim.fn.stdpath("config"),
	})
end, { desc = "Search neovim config" })

-- LSP-aware pickers (super useful once LSP is on)
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Telescope diagnostics picker" }) -- diagnostics picker
vim.keymap.set("n", "<leader>fw", builtin.lsp_workspace_symbols, { desc = "Telescope workspace symbols" })
vim.keymap.set("n", "<leader>fo", builtin.lsp_document_symbols, { desc = "Telescope document symbols" })

vim.keymap.set("n", "<leader>td", function()
	local cfg = vim.diagnostic.config()
	vim.diagnostic.config({ virtual_text = not cfg.virtual_text })
end, { desc = "Toggle diagnostic virtual_text" })
