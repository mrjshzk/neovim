local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },
		-- You can customize some of the format options for the filetype (:help conform.format)
		rust = { "rustfmt", lsp_format = "fallback" },
		-- Conform will run the first available formatter
		javascript = { "prettierd", "prettier", stop_after_first = true },
<<<<<<< HEAD
		html = { "prettierd", "prettier", stop_after_first = true },
		typst = { "typstyle" },
=======
		godot = { "gdformat" },
		gdscript = { "gdformat" },
>>>>>>> 4c97e6ed9780bd119952638b1b0051c5f1a74936
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(ev)
		conform.format({ bufnr = ev.buf })
	end,
})
