return {
	-- tokyonight
	-- url: https://github.com/folke/tokyonight.nvim
	{
		"folke/tokyonight.nvim",
		lazy = true,
		opts = { style = "Night" }, -- Storm, Night, Moon, Day
	},
	-- catppuccin
	-- url: https://github.com/catppuccin/nvim
	{
		"catppuccin/nvim",
		flavour = "mocha", -- latte, frappe, macchiato, mocha
		lazy = true,
		name = "catppuccin",
		opts = {
			integrations = {
				alpha = true,
				cmp = true,
				flash = true,
				gitsigns = true,
				illuminate = true,
				indent_blankline = { enabled = true },
				lsp_trouble = true,
				mason = true,
				mini = true,
				native_lsp = {
					enabled = true,
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
				},
				navic = { enabled = true, custom_bg = "lualine" },
				neotest = true,
				noice = true,
				notify = true,
				neotree = true,
				semantic_tokens = true,
				telescope = true,
				treesitter = true,
				which_key = true,
			},
		},
	},
}
