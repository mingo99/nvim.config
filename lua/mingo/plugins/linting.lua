-- An asynchronous linter plugin for Neovim (>= 0.6.0) complementary to the built-in Language Server Protocol support.
-- url: https://github.com/mfussenegger/nvim-lint
return {
	"mfussenegger/nvim-lint",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	config = function()
		local lint = require("lint")

		-- customize linter
		lint.linters.veriblelint = {
			cmd = "verible-verilog-lint",
			stdin = true,
			append_fname = true,
		}
		lint.linters.tomllint = {
			cmd = "taplo",
			stdin = true,
			append_fname = true,
			args = { "lint" },
		}

		lint.linters_by_ft = {
			verilog = { "veriblelint" },
			markdown = { "markdownlint" },
			json = { "jsonlint" },
			yaml = { "yamllint" },
			toml = { "tomllint" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.api.nvim_create_user_command("LintInfo", function()
			print(vim.inspect(lint.linters_by_ft[vim.bo.filetype]))
		end, { nargs = 0 })

		vim.keymap.set("n", "gl", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
