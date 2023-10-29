-- markdown preview
-- url: https://github.com/iamcco/markdown-preview.nvim
return {
	"iamcco/markdown-preview.nvim",
	ft = "markdown",
	-- build = "cd app ; yarn install",
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
	lazy = true,
	keys = {
		{ "<leader>mp", "<cmd>MarkdownPreview<cr>", desc = " Markdown preview" },
	},
	config = function()
		-- vim.cmd([[
		-- function OpenMarkdownPreview (url)
		-- execute "silent ! edge --new-window --app=" . a:url
		-- endfunction
		-- ]])
		vim.g.mkdp_auto_close = true
		vim.g.mkdp_open_to_the_world = false
		vim.g.mkdp_open_ip = "127.0.0.1"
		vim.g.mkdp_port = "8888"
		vim.g.mkdp_browser = ""
		-- vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
		vim.g.mkdp_echo_preview_url = true
		vim.g.mkdp_page_title = "${name}"
	end,
}
