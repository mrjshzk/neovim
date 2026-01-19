local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- plugins go here
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme carbonfox")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
	},
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"stylua",
					"ts_ls",
				},
			})
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("config.cmp")
		end,
	},

	{
		"stevearc/conform.nvim",
		config = function()
			require("config.format")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "v0.2.1",
		config = function()
			require("telescope").setup({})
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
			options = {
				delay = 0,
			},
		},
	},
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{
		"echasnovski/mini.comment",
		version = false,
		config = function()
			require("mini.comment").setup()
		end,
	},
	{
		"echasnovski/mini.surround",
		version = false,
		config = function()
			require("mini.surround").setup()
		end,
	},
	{
		"echasnovski/mini.pairs",
		version = false,
		config = function()
			require("mini.pairs").setup()
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional icons
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					section_separators = "",
					component_separators = "",
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff" },
					lualine_c = { { "filename", path = 1 } },
					lualine_x = {
						{ "diagnostics" },
						"encoding",
						"filetype",
						{
							function()
								local clients = vim.lsp.get_clients({ bufnr = 0 })
								return (#clients > 0) and ("󰫹󰬀󰫽  " .. clients[1].name) or "No LSP. :("
							end,
						},
					},
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},
	{
		"echasnovski/mini.ai",
		version = false,
		config = function()
			require("mini.ai").setup()
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		lazy = false,
	},
	{
		"yuukiflow/Arduino-Nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "arduino",
				callback = function()
					require("Arduino-Nvim")
				end,
			})
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
})
