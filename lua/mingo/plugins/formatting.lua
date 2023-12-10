-- Lightweight yet powerful formatter plugin for Neovim
-- url: https://github.com/stevearc/conform.nvim
return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	config = function()
		local conform = require("conform")
		local home_dir = vim.fn.expand("~")

		conform.setup({
			formatters = {
				veriblefmt = {
					command = home_dir .. "/.local/share/nvim/mason/bin/verible-verilog-format",
					args = {
						"--indentation_spaces=4",
						"-",
					},
					stdin = true,
				},
			},
			formatters_by_ft = {
				json = { "jq" },
				markdown = { "markdownlint", "markdown-toc" },
				lua = { "stylua" },
				python = { "isort", "black" },
				verilog = { "veriblefmt" },
				systemverilog = { "veriblefmt" },
				yaml = { "yamlfmt", "yamlfix" },
				toml = { "taplo" },
			},
			format_on_save = function()
				-- Disable with a global or buffer-local variable
				if vim.g.autoformat then
					return { timeout_ms = 500, lsp_fallback = true }
				else
					return
				end
			end,
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
