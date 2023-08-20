return {
	-- a blazing fast and easy to configure Neovim statusline written in Lua
	-- url: https://github.com/nvim-lualine/lualine.nvim
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function()
			local icons = require("config").icons
			local Util = require("util")

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
					local icons = require("config").icons.diagnostics
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
}