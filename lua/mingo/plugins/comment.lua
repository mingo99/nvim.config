return {
	-- todo-comments is a lua plugin for Neovim >= 0.8.0 to highlight and search
	-- for todo comments like TODO, HACK, BUG in your code base.
	-- url: https://github.com/folke/todo-comments.nvim
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPost", "BufNewFile" },
		config = true,
     	-- stylua: ignore
     	keys = {
     	 	{ "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
     	 	{ "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
     	 	{ "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
     	 	{ "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
     	 	{ "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
     	 	{ "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
     	},
	},

	-- comment functions so powerful—no comment necessary
	-- url: https://github.com/preservim/nerdcommenter
	-- {
	-- "preservim/nerdcommenter",
	-- event = "VeryLazy",
	-- config = function()
	-- vim.g.NERDCreateDefaultMappings = 1
	-- vim.g.NERDSpaceDelims = 1
	-- vim.g.NERDCommentEmptyLines = 1
	-- end,
	-- keys = {},
	-- },

	-- Smart and Powerful commenting plugin for neovim
	-- url: https://github.com/numToStr/Comment.nvim
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			-- import comment plugin safely
			local comment = require("Comment")

			local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

			-- enable comment
			comment.setup({
				-- for commenting tsx and jsx files
				pre_hook = ts_context_commentstring.create_pre_hook(),
			})
		end,
	},

	-- a neovim plugin for setting the commentstring option based on the cursor location in the file
	-- the location is checked via treesitter queries
	-- url: https://github.com/JoosepAlviste/nvim-ts-context-commentstring
	{ "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
}
