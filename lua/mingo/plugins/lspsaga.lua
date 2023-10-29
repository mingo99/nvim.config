-- improves the Neovim built-in LSP experience.
-- url: https://github.com/nvimdev/lspsaga.nvim
return {
	"nvimdev/lspsaga.nvim",
	event = "LspAttach",
	cmd = "Lspsaga",
	ft = { "c", "cpp", "json", "lua", "verilog", "python" },
	config = function()
		require("lspsaga").setup({})
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
	keys = {
		{ "<leader>o", "<cmd>Lspsaga outline<CR>", desc = "Symbols outline" },
	},
}
