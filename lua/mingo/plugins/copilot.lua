return {
	-- Native Codeium plugin for Neovim
	-- url: https://github.com/zbirenbaum/copilot.lua
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		opts = {
			suggestion = { enabled = true, auto_trigger = true },
			panel = { enabled = false },
			filetypes = {
				markdown = true,
				help = true,
			},
		},
	},

	-- Copilot cmp source
	-- url: https://github.com/zbirenbaum/copilot-cmp
	{
		"zbirenbaum/copilot-cmp",
		dependencies = "copilot.lua",
		opts = {},
		config = function(_, opts)
			local copilot_cmp = require("copilot_cmp")
			copilot_cmp.setup(opts)
			-- attach cmp source whenever copilot attaches
			-- fixes lazy-loading issues with the copilot cmp source
			require("mingo.util").on_attach(function(client)
				if client.name == "copilot" then
					copilot_cmp._on_insert_enter({})
				end
			end)
		end,
	},
}
