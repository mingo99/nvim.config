return {
	-- a blazing fast and easy to configure Neovim statusline written in Lua
	-- url: https://github.com/nvim-lualine/lualine.nvim
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function()
			local Util = require("util")
			local icons = Util.icons

			return {
				options = {
					theme = "auto",
					globalstatus = true,
					disabled_filetypes = { statusline = { "dashboard", "alpha" } },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = {
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warn,
								info = icons.diagnostics.Info,
								hint = icons.diagnostics.Hint,
							},
						},
						{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
						{ "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
     	 	 	 	 	-- stylua: ignore
     	 	 	 	 	{
     	 	 	 	 	 	function() return require("nvim-navic").get_location() end,
     	 	 	 	 	 	cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
     	 	 	 	 	},
					},
					lualine_x = {
      	 	 	 	 	-- stylua: ignore
						{
							function() return require("noice").api.status.command.get() end,
							cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
							color = Util.fg("Statement"),
						},
     	 	 	 	 	-- stylua: ignore
     	 	 	 	 	{
     	 	 	 	 	 	function() return require("noice").api.status.mode.get() end,
     	 	 	 	 	 	cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
     	 	 	 	 	 	color = Util.fg("Constant"),
     	 	 	 	 	},
     	 	 	 	 	-- stylua: ignore
     	 	 	 	 	{
     	 	 	 	 	 	function() return "  " .. require("dap").status() end,
     	 	 	 	 	 	cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
     	 	 	 	 	 	color = Util.fg("Debug"),
     	 	 	 	 	},
						{
							require("lazy.status").updates,
							cond = require("lazy.status").has_updates,
							color = Util.fg("Special"),
						},
						{
							"diff",
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
							},
						},
                        -- stylua: ignore
                        {
                            -- Lsp server name
                            function()
                                local msg = "no client"
                                local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
                                local clients = vim.lsp.get_active_clients()
                                if next(clients) == nil then
                                    return msg
                                end
                                for _, client in ipairs(clients) do
                                    local filetypes = client.config.filetypes
                                    if client.name ~= "null-ls" and filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                                        return client.name
                                    end
                                end
                                return msg
                            end,
                            icon = " ",
                            color = {fg = "#87ceeb"},
                        },
					},
					lualine_y = {
						{ "progress", separator = " ", padding = { left = 1, right = 0 } },
						{ "location", padding = { left = 0, right = 1 } },
					},
					lualine_z = {
						function()
							return " " .. os.date("%R")
						end,
					},
				},
				extensions = { "neo-tree", "lazy" },
			}
		end,
	},

	-- this plugin shamelessly attempts to emulate the aesthetics of GUI text editors/Doom Emacs
	-- it was inspired by a screenshot of DOOM Emacs using centaur tabs
	-- url: https://github.com/akinsho/bufferline.nvim
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
			{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
		},
		opts = {
			options = {
     	 	 	-- stylua: ignore
     	 	 	close_command = function(n) require("mini.bufremove").delete(n, false) end,
     	 	 	-- stylua: ignore
     	 	 	right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
				diagnostics = "nvim_lsp",
				always_show_bufferline = false,
				diagnostics_indicator = function(_, _, diag)
					local icons = require("util").icons.diagnostics
					local ret = (diag.error and icons.Error .. diag.error .. " " or "")
						.. (diag.warning and icons.Warn .. diag.warning or "")
					return vim.trim(ret)
				end,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
					},
				},
			},
		},
	},

	-- better vim ui
	-- url: https://github.com/stevearc/dressing.nvim
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},

	-- Dashboard.
	-- This runs when neovim starts, and is what displays the "LAZYVIM" banner.
	-- url: https://github.com/goolord/alpha-nvim
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			local logo = [[
     	 	     ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
     	 	     ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z    
     	 	     ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z       
     	 	     ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z         
     	 	     ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
     	 	     ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
     	 	]]

			dashboard.section.header.val = vim.split(logo, "\n")
			dashboard.section.buttons.val = {
				dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
				dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
				dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
				dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
				dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
				dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
				dashboard.button("q", " " .. " Quit", ":qa<CR>"),
			}
			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = "AlphaButtons"
				button.opts.hl_shortcut = "AlphaShortcut"
			end
			dashboard.section.header.opts.hl = "AlphaHeader"
			dashboard.section.buttons.opts.hl = "AlphaButtons"
			dashboard.section.footer.opts.hl = "AlphaFooter"
			dashboard.opts.layout[1].val = 8
			return dashboard
		end,
		config = function(_, dashboard)
			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			require("alpha").setup(dashboard.opts)

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},

	-- highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu
	-- url: https://github.com/folke/noice.nvim
	{
		{
			"folke/noice.nvim",
			event = "VeryLazy",
			opts = {
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				routes = {
					{
						filter = {
							event = "msg_show",
							any = {
								{ find = "%d+L, %d+B" },
								{ find = "; after #%d+" },
								{ find = "; before #%d+" },
							},
						},
						view = "mini",
					},
				},
				presets = {
					bottom_search = true,
					command_palette = true,
					long_message_to_split = true,
					inc_rename = true,
				},
			},
         	-- stylua: ignore
         	keys = {
         	 	{ "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
         	 	{ "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
         	 	{ "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
         	 	{ "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
         	 	{ "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
         	 	{ "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
         	 	{ "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
         	},
		},
	},
	-- which-key for noice
	{
		"folke/which-key.nvim",
		opts = function(_, opts)
			if require("util").has("noice.nvim") then
				opts.defaults["<leader>sn"] = { name = "+noice" }
			end
		end,
	},

	-- a fancy, configurable, notification manager for NeoVim
	-- url: https://github.com/rcarriga/nvim-notify
	{
		"rcarriga/nvim-notify",
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Dismiss all Notifications",
			},
		},
		opts = {
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		},
		init = function()
			-- when noice is not enabled, install notify on VeryLazy
			local Util = require("util")
			if not Util.has("noice.nvim") then
				Util.on_very_lazy(function()
					vim.notify = require("notify")
				end)
			end
		end,
	},

	-- ui component library for neovim.
	-- url: https://github.com/MunifTanjim/nui.nvim
	{ "MunifTanjim/nui.nvim", lazy = true },

	-- use neovim terminal in the floating/popup window.
	-- url: https://github.com/voldikss/vim-floaterm
	-- {
	-- "voldikss/vim-floaterm",
	-- event = "VeryLazy",
	-- config = function()
	-- vim.g.floaterm_title = "Term: $1/$2"
	-- end,
	-- },

	-- create and manage predefined window layout_strats
	-- url: https://github.com/folke/edgy.nvimdev
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
            { "<leader>uE", function() require("edgy").select() end, desc = "Edgy Select Window" },
		},
		opts = function()
			local opts = {
				bottom = {
					{
						ft = "toggleterm",
						size = { height = 0.4 },
						filter = function(buf, win)
							return vim.api.nvim_win_get_config(win).relative == ""
						end,
					},
					{
						ft = "noice",
						size = { height = 0.4 },
						filter = function(buf, win)
							return vim.api.nvim_win_get_config(win).relative == ""
						end,
					},
					{
						ft = "lazyterm",
						title = "LazyTerm",
						size = { height = 0.4 },
						filter = function(buf)
							return not vim.b[buf].lazyterm_cmd
						end,
					},
					"Trouble",
					{ ft = "qf", title = "QuickFix" },
					{
						ft = "help",
						size = { height = 20 },
						-- don't open help files in edgy that we're editing
						filter = function(buf)
							return vim.bo[buf].buftype == "help"
						end,
					},
					{ ft = "spectre_panel", size = { height = 0.4 } },
					{ title = "Neotest Output", ft = "neotest-output-panel", size = { height = 15 } },
				},
				left = {
					{
						title = "Neo-Tree",
						ft = "neo-tree",
						filter = function(buf)
							return vim.b[buf].neo_tree_source == "filesystem"
						end,
						pinned = true,
						open = function()
							vim.api.nvim_input("<esc><space>e")
						end,
						size = { height = 0.5 },
					},
					{ title = "Neotest Summary", ft = "neotest-summary" },
					{
						title = "Neo-Tree Git",
						ft = "neo-tree",
						filter = function(buf)
							return vim.b[buf].neo_tree_source == "git_status"
						end,
						pinned = true,
						open = "Neotree position=right git_status",
					},
					{
						title = "Neo-Tree Buffers",
						ft = "neo-tree",
						filter = function(buf)
							return vim.b[buf].neo_tree_source == "buffers"
						end,
						pinned = true,
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
			local Util = require("util")
			if Util.has("symbols-outline.nvim") then
				table.insert(opts.left, {
					title = "Outline",
					ft = "Outline",
					pinned = true,
					open = "SymbolsOutline",
				})
			end
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
	{
		"akinsho/bufferline.nvim",
		optional = true,
		opts = function()
			local Offset = require("bufferline.offset")
			if not Offset.edgy then
				local get = Offset.get
				---@diagnostic disable-next-line
				Offset.get = function()
					if package.loaded.edgy then
						local layout = require("edgy.config").layout
						local ret = { left = "", left_size = 0, right = "", right_size = 0 }
						for _, pos in ipairs({ "left", "right" }) do
							local sb = layout[pos]
							if sb and #sb.wins > 0 then
								local title = " Sidebar" .. string.rep(" ", sb.bounds.width - 8)
								ret[pos] = "%#EdgyTitle#" .. title .. "%*" .. "%#WinSeparator#│%*"
								ret[pos .. "_size"] = sb.bounds.width
							end
						end
						ret.total_size = ret.left_size + ret.right_size
						if ret.total_size > 0 then
							return ret
						end
					end
					return get()
				end
				Offset.edgy = true
			end
		end,
	},

	-- animate common neovim actions
	-- url: https://github.com/echasnovski/mini.animate
	{
		"echasnovski/mini.animate",
		event = "VeryLazy",
		opts = function()
			-- don't use animate when scrolling with the mouse
			local mouse_scrolled = false
			for _, scroll in ipairs({ "Up", "Down" }) do
				local key = "<ScrollWheel" .. scroll .. ">"
				vim.keymap.set({ "", "i" }, key, function()
					mouse_scrolled = true
					return key
				end, { expr = true })
			end

			local animate = require("mini.animate")
			return {
				resize = {
					timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
				},
				scroll = {
					timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
					subscroll = animate.gen_subscroll.equal({
						predicate = function(total_scroll)
							if mouse_scrolled then
								mouse_scrolled = false
								return false
							end
							return total_scroll > 1
						end,
					}),
				},
			}
		end,
	},
}
