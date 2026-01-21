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
		godot = { "gdformat" },
		gdscript = { "gdformat" },
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(ev)
		conform.format({ bufnr = ev.buf })
	end,
})
