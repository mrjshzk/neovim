local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local group = augroup("my_autocmds", { clear = true })

-- Highlight yanked text (quick visual feedback)
autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Remove trailing whitespace on save (only for normal text-like filetypes)
autocmd("BufWritePre", {
  group = group,
  pattern = { "*.lua", "*.py", "*.js", "*.ts", "*.jsx", "*.tsx", "*.go", "*.rs", "*.c", "*.cpp", "*.h", "*.md", "*.txt" },
  callback = function()
    local view = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

-- Close certain "utility" buffers with q
autocmd("FileType", {
  group = group,
  pattern = { "help", "man", "qf", "lspinfo" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})
