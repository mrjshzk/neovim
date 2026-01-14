vim.diagnostic.config({
	virtual_text = false, -- less noisy
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

-- show diagnostic float on hover
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false })
	end,
})
