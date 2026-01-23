vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})

vim.lsp.config["luals"] = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = {
				checkThirdParty = false,
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = { enable = false },
		},
	},
}
vim.lsp.config("pylsp", {
	cmd = { "pylsp" },
	filetypes = { "python" },
	{ "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
})

vim.lsp.enable("pylsp")

vim.lsp.config["cssls"] = {
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },
	root_markers = { "package.json", ".git" },
	settings = {
		css = { validate = true },
		scss = { validate = true },
		less = { validate = true },
	},
}

vim.lsp.config["ts_ls"] = {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
	settings = {
		completions = {
			completeFunctionCalls = true,
		},
	},
}

vim.lsp.config["nil_ls"] = {
	cmd = { "nil" },
	filetypes = { "nix" },
	root_markers = { "flake.nix", "default.nix", ".git" },
	settings = {
		["nil"] = {
			formatting = {
				command = { "alejandra" },
			},
		},
	},
}

vim.lsp.config["rust_analyzer"] = {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { "Cargo.toml", "rust-project.json", ".git" },
	settings = {
		["rust-analyzer"] = {
			cargo = { allFeatures = true },
			formatting = {
				command = { "rustfmt" },
			},
		},
	},
}

-- C / C++ via clangd
vim.lsp.config["clangd"] = {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=never",
		"--completion-style=detailed",
		"--query-driver=/nix/store/*-gcc-*/bin/gcc*,/nix/store/*-clang-*/bin/clang*,/run/current-system/sw/bin/cc*",
	},
	filetypes = { "c", "cpp", "objc", "objcpp" },
	root_markers = { "compile_commands.json", ".clangd", "configure.ac", "Makefile", ".git" },
	init_options = {
		fallbackFlags = { "-std=c23" }, -- Default to C23
	},
}

vim.lsp.config["jsonls"] = {
	cmd = { "vscode-json-languageserver", "--stdio" },
	filetypes = { "json", "jsonc" },
	root_markers = { "package.json", ".git", "config.jsonc" },
}

vim.lsp.config["gopls"] = {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { "go.mod", "go.work", ".git" },
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
}

vim.lsp.config["tinymist"] = {
	cmd = { "tinymist" },
	filetypes = { "typst" },
	root_markers = { ".git" },
}
vim.lsp.enable("tinymist")
-- Text Editor > Behavior
--
-- Auto Reload Scripts on External Change to On
--
-- Text Editor > External
--
-- Exec Path : /path/to/nvim
--
-- Exec Flags: --server /tmp/godot.pipe --remote-send "<esc>:n {file}<CR>:call cursor({line},{col})<CR>"
--
-- Use External Editor: On
vim.lsp.config["gdscript"] = {
	cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
	filetypes = { "gd", "gdscript", "gdscript3" },
	root_markers = { "project.godot", ".git" },
	on_init = function(client, init_result)
		vim.fn.serverstart("/tmp/godot.pipe")
	end,
}
vim.lsp.enable("gdscript")

---@diagnostic disable-next-line: invisible
for name, _ in pairs(vim.lsp.config._configs) do
	if name ~= "*" then -- Skip the wildcard config
		vim.lsp.enable(name)
	end
end
