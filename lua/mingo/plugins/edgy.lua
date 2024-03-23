-- create and manage predefined window layout_strats
-- url: https://github.com/folke/edgy.nvim
return {
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>ue",
				function()
					require("edgy").toggle()
				end,
				desc = "edgy toggle",
			},
            -- stylua: ignore
            { "<leader>uE", function() require("edgy").select() end, desc = "edgy Select Window" },
		},
		opts = function()
			local opts = {
				bottom = {
					{
						ft = "toggleterm",
						size = { height = 0.3 },
						filter = function(_, win)
							return vim.api.nvim_win_get_config(win).relative == ""
						end,
					},
					{
						ft = "noice",
						size = { height = 0.4 },
						filter = function(_, win)
							return vim.api.nvim_win_get_config(win).relative == ""
						end,
					},
					{
						ft = "lazyterm",
						title = "Lazyterm",
						size = { height = 0.3 },
						filter = function(buf)
							return not vim.b[buf].lazyterm_cmd
						end,
					},
					"Trouble",
					{ ft = "qf", title = "QuickFix" },
					{
						ft = "help",
						size = { height = math.floor(vim.o.lines * 0.5) },
						-- don't open help files in edgy that we're editing
						filter = function(buf)
							return vim.bo[buf].buftype == "help"
						end,
					},
					{ ft = "spectre_panel", size = { height = 0.4 } },
					{ title = "Neotest Output", ft = "neotest-output-panel", size = { height = 15 } },
				},
				left = {
					-- {
					-- 	ft = "neo-tree",
					-- 	title = "Explorer",
					-- 	filter = function(buf)
					-- 		return vim.b[buf].neo_tree_source == "filesystem"
					-- 	end,
					-- 	pinned = true,
					-- 	open = function()
					-- 		vim.api.nvim_input("<esc><space>e")
					-- 	end,
					-- 	size = { height = 0.5 },
					-- },
					{ title = "Neotest Summary", ft = "neotest-summary" },
					{
						title = "Git",
						ft = "neo-tree",
						filter = function(buf)
							return vim.b[buf].neo_tree_source == "git_status"
						end,
						pinned = false,
						open = "Neotree position=right git_status",
					},
					{
						title = "Buffers",
						ft = "neo-tree",
						filter = function(buf)
							return vim.b[buf].neo_tree_source == "buffers"
						end,
						pinned = false,
						open = "Neotree position=top buffers",
					},
					"neo-tree",
				},
				keys = {
					-- increase width
					["<c-Right>"] = function(win)
						win:resize("width", 2)
					end,
					-- decrease width
					["<c-Left>"] = function(win)
						win:resize("width", -2)
					end,
					-- increase height
					["<c-Up>"] = function(win)
						win:resize("height", 2)
					end,
					-- decrease height
					["<c-Down>"] = function(win)
						win:resize("height", -2)
					end,
				},
			}

			return opts
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		optional = true,
		opts = function(_, opts)
			opts.open_files_do_not_replace_types = opts.open_files_do_not_replace_types
				or { "terminal", "Trouble", "qf", "Outline" }
			table.insert(opts.open_files_do_not_replace_types, "edgy")
		end,
	},
}
