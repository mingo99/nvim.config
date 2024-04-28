return {
	-- this plugin shamelessly attempts to emulate the aesthetics of GUI text editors/Doom Emacs
	-- it was inspired by a screenshot of DOOM Emacs using centaur tabs
	-- url: https://github.com/akinsho/bufferline.nvim
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "gb", "<Cmd>BufferLinePick<CR>", desc = "Select buffer in view" },
			{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
			{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
			{ "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
			{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
			{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
		},
		opts = {
			options = {
				close_command = function(n)
					require("mini.bufremove").delete(n, false)
				end,
				right_mouse_command = function(n)
					require("mini.bufremove").delete(n, false)
				end,
				diagnostics = "nvim_lsp",
				always_show_bufferline = false,
				diagnostics_indicator = function(_, _, diag)
					local icons = require("mingo.util").icons.diagnostics
					local ret = (diag.error and icons.Error .. diag.error .. " " or "")
						.. (diag.warning and icons.Warn .. diag.warning or "")
					return vim.trim(ret)
				end,
				separator_style = { "", "" },
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo Tree",
						text_align = "left",
						highlight = "Directory",
						separator = true,
					},
				},
			},
		},
		config = function(_, opts)
			require("bufferline").setup(opts)
			-- Fix bufferline when restoring a session
			vim.api.nvim_create_autocmd("BufAdd", {
				callback = function()
					vim.schedule(function()
						pcall(nvim_bufferline)
					end)
				end,
			})
		end,
	},

	-- buffer removing (unshow, delete, wipeout), which saves window layout
	-- url: https://github.com/echasnovski/mini.bufremove
	{
		"echasnovski/mini.bufremove",
        -- stylua: ignore
        keys = {
            { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
            { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
        },
	},
}
