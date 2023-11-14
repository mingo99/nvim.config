-- Lightweight yet powerful formatter plugin for Neovim
-- url: https://github.com/stevearc/conform.nvim
return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters = {
				veriblefmt = {
					command = "verible-verilog-format",
				},
			},
			formatters_by_ft = {
				json = { "jq" },
				markdown = { "markdownlint", "markdown-toc" },
				lua = { "stylua" },
				python = { "isort", "black" },
				verilog = { "veriblefmt" },
				yaml = { "yamlfmt", "yamlfix" },
				toml = { "taplo" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>cf", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
