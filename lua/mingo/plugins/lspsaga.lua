-- improves the Neovim built-in LSP experience.
-- url: https://github.com/nvimdev/lspsaga.nvim
return {
	"nvimdev/lspsaga.nvim",
	event = "LspAttach",
	cmd = "Lspsaga",
	ft = { "c", "cpp", "json", "lua", "verilog", "python", "markdown", "make", "yaml" },
	config = function()
		require("lspsaga").setup({
			outline = {
				layout = "float",
				keys = {
					jump = "<cr>",
				},
			},
			lightbulb = {
				enable = true,
				sign = true,
				virtual_text = false,
				debounce = 10,
				sign_priority = 40,
			},
			hover = {
				open_link = "gx",
				open_cmd = "!wslview",
			},
			diagnostic = {
				max_height = 0.8,
				keys = {
					quit = { "q", "<ESC>" },
				},
			},
		})
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
	keys = {
		{ "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "Next Diagnostic" },
		{ "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "Prev Diagnostic" },
		{
			"]e",
			function()
				require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
			end,
			desc = "Next Error",
		},
		{
			"[e",
			function()
				require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
			end,
			desc = "Prev Error",
		},
		{
			"]w",
			function()
				require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.WARN })
			end,
			desc = "Next Warning",
		},
		{
			"[w",
			function()
				require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.WARN })
			end,
			desc = "Prev Warning",
		},
		{ "gh", "<cmd>Lspsaga hover_doc<CR>", desc = "Hover" },
		{ "<leader>o", "<cmd>Lspsaga outline<CR>", desc = "Symbols outline" },
		{ "<leader>ca", "<cmd>Lspsaga code_action<CR>", desc = "Code action", mode = { "n", "v" } },
		{ "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "Show line diagnostics" },
		{ "<leader>rn", "<cmd>Lspsaga rename<CR>", desc = "Rename" },
	},
}
