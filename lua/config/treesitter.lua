require("nvim-treesitter").setup({
	-- keep this small; add langs as you need them
	ensure_installed = { "lua", "vim", "vimdoc", "python", "javascript", "typescript", "go" },

	auto_install = true, -- installs missing parser when entering buffer (requires git)
	highlight = { enable = true },
	indent = { enable = true },
})
