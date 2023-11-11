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
     	 	-- { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
     	 	{ "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
     	 	{ "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
     	 	{ "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
     	},
	},

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
				--Add a space b/w comment and the line
				padding = true,
				---Whether the cursor should stay at its position
				sticky = true,
				---Lines to be ignored while (un)comment
				ignore = nil,
				---LHS of toggle mappings in NORMAL mode
				toggler = {
					---Line-comment toggle keymap
					line = "gcc",
					---Block-comment toggle keymap
					block = "gbc",
				},
				---LHS of operator-pending mappings in NORMAL and VISUAL mode
				opleader = {
					---Line-comment keymap
					line = "gc",
					---Block-comment keymap
					block = "gb",
				},
				---LHS of extra mappings
				extra = {
					---Add comment on the line above
					above = "gcO",
					---Add comment on the line below
					below = "gco",
					---Add comment at the end of line
					eol = "gca",
				},
				---Enable keybindings
				---NOTE: If given `false` then the plugin won't create any mappings
				mappings = {
					---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
					basic = true,
					---Extra mapping; `gco`, `gcO`, `gcA`
					extra = true,
				},
				---Function to call before (un)comment
				-- for commenting tsx and jsx files
				pre_hook = ts_context_commentstring.create_pre_hook(),
				---Function to call after (un)comment
				post_hook = nil,
			})
		end,
	},

	-- a neovim plugin for setting the commentstring option based on the cursor location in the file
	-- the location is checked via treesitter queries
	-- url: https://github.com/JoosepAlviste/nvim-ts-context-commentstring
	{ "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
}
