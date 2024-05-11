-- A very fast, powerful, extensible and asynchronous Neovim HTTP client written in Lua.
-- url: https://github.com/rest-nvim/rest.nvim
return {
	"rest-nvim/rest.nvim",
	ft = "http",
	keys = {
		{ "<leader>rr", "<cmd>Rest run<cr>", "Run request under the cursor" },
		{ "<leader>rl", "<cmd>Rest run last<cr>", "Re-run latest request" },
	},
	dependencies = {
		"vhyrro/luarocks.nvim",
		priority = 1000,
		config = true,
		opts = {
			rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
		},
	},
	opts = {
		formatters = {
			html = "prettier",
		},
	},
	config = function()
		require("rest-nvim").setup()
	end,
}
