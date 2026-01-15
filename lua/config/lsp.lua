-- global LSP keymaps on attach
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local map = function(mode, lhs, rhs)
			vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, silent = true })
		end

		map("n", "gd", vim.lsp.buf.definition)
		map("n", "gD", vim.lsp.buf.declaration)
		map("n", "gr", vim.lsp.buf.references)
		map("n", "K", vim.lsp.buf.hover)
		map("n", "<leader>rn", vim.lsp.buf.rename)
		map("n", "<leader>ca", vim.lsp.buf.code_action)
		map("n", "[d", vim.diagnostic.goto_prev)
		map("n", "]d", vim.diagnostic.goto_next)
	end,
})

-- ----------------
-- Server configs
-- ----------------

local caps = require("cmp_nvim_lsp").default_capabilities()

local function GetLsp(bin)
	return vim.fn.stdpath("data") .. "/mason/bin/" .. bin
end

vim.lsp.config("lua_ls", {
	cmd = { GetLsp("lua-language-server") },
	filetypes = { "lua" },
	capabilities = caps,
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			workspace = { checkThirdParty = false },
		},
	},
})
vim.lsp.enable("lua_ls")

vim.lsp.config("ts_ls", {
	cmd = { GetLsp("typescript-language-server"), "--stdio" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	capabilities = caps,
})
vim.lsp.enable("ts_ls")

vim.lsp.config("nil_ls", {
	cmd = { GetLsp("nil") },
	filetypes = { "nix" },
	capabilities = caps,
})
vim.lsp.enable("nil_ls")

local arduino_lsp = "arduino-language-server"
vim.lsp.config(arduino_lsp, {
	cmd = { GetLsp(arduino_lsp) },
	filetypes = { "ino", "arduino" },
	capabilities = caps,
})
vim.lsp.enable(arduino_lsp)

local qml_lsp = "qmlls"
vim.lsp.config(qml_lsp, {
	cmd = { "qmlls", "-E" },
	filetypes = { "qml", "qmljs" },
	root_markers = { ".git" },
	capabilities = caps,
})
vim.lsp.enable(qml_lsp)

-- Inlay hints
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)

		-- Inlay hints (if supported by this Neovim + server)
		if vim.lsp.inlay_hint and client and client.supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
			vim.keymap.set("n", "<leader>th", function()
				local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
				vim.lsp.inlay_hint.enable(not enabled, { bufnr = event.buf })
			end, { buffer = event.buf, desc = "Toggle inlay hints" })
		end
	end,
})
