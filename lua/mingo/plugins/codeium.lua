return {
	-- Native Codeium plugin for Neovim
	-- url: https://github.com/Exafunction/codeium.vim
	{
		"Exafunction/codeium.vim",
		event = "BufEnter",
		config = function()
			vim.keymap.set("i", "<c-]>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })
		end,
	},
}
