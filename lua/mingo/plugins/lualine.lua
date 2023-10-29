return {
	-- a blazing fast and easy to configure Neovim statusline written in Lua
	-- url: https://github.com/nvim-lualine/lualine.nvim
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function()
			local Util = require("mingo.util")
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

	-- ui component library for neovim.
	-- url: https://github.com/MunifTanjim/nui.nvim
	{ "MunifTanjim/nui.nvim", lazy = true },

	-- lsp symbol navigation for lualine
	-- url: https://github.com/SmiteshP/nvim-navic
	-- {
	-- "SmiteshP/nvim-navic",
	-- lazy = true,
	-- init = function()
	-- vim.g.navic_silence = true
	-- require("mingo.util").on_attach(function(client, buffer)
	-- if client.server_capabilities.documentSymbolProvider then
	-- require("nvim-navic").attach(client, buffer)
	-- end
	-- end)
	-- end,
	-- opts = function()
	-- return {
	-- separator = " ",
	-- highlight = true,
	-- depth_limit = 5,
	-- icons = require("mingo.util").icons.kinds,
	-- }
	-- end,
	-- },
}
