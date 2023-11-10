-- An asynchronous linter plugin for Neovim (>= 0.6.0) complementary to the built-in Language Server Protocol support.
-- url: https://github.com/mfussenegger/nvim-lint
return {
	"mfussenegger/nvim-lint",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	config = function()
		local lint = require("lint")

		-- customize linter
		lint.linters.verible = {
			cmd = "verible-verilog-lint",
		}

		lint.linters_by_ft = {
			python = { "pylint" },
			verilog = { "verible" },
			markdown = { "vale" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>tl", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
