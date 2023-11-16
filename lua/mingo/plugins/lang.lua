return {
	-- lua
	-- snippets for lua
	-- url: https://github.com/L3MON4D3/LuaSnip
	{
		"L3MON4D3/LuaSnip",
		build = (not jit.os:find("Windows"))
				and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
			or nil,
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
        -- stylua: ignore
        keys = {
            {
                "<tab>",
                function()
                    return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
                end,
                expr = true, silent = true, mode = "i",
            },
            { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
            { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
        },
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			-- make sure mason installs the server
			servers = {
				-- lua
				lua_ls = {
					---@type LazyKeys[]
					-- keys = {},
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},
			},
		},
	},

	-- json
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"b0o/SchemaStore.nvim",
			version = false, -- last release is way too old
		},
		opts = {
			-- make sure mason installs the server
			servers = {
				jsonls = {
					-- lazy-load schemastore when needed
					on_new_config = function(new_config)
						new_config.settings.json.schemas = new_config.settings.json.schemas or {}
						vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
					end,
					settings = {
						json = {
							format = {
								enable = true,
							},
							validate = { enable = true },
						},
					},
				},
			},
		},
	},

	-- hdl
	{
		"neovim/nvim-lspconfig",
		opts = {
			-- make sure mason installs the server
			servers = {
				verible = {
					root_dir = function()
						return vim.loop.cwd()
					end,
					cmd = {
						"verible-verilog-ls",
						-- "--wrap_end_else_clauses",
						"--indentation_spaces=4",
						"--rules_config_search",
					},
				},
			},
		},
	},
	{
		-- auto instantiation for verilog
		-- url: https://github.com/mingo99/verilog-autoinst.nvim
		"mingo99/verilog-autoinst.nvim",
		event = "VeryLazy",
		cmd = "AutoInst",
		keys = { { "<leader>fv", "<cmd>AutoInst<cr>", desc = "Automatic instantiation for verilog" } },
		dependencies = { "nvim-telescope/telescope.nvim" },
		opts = {
			cmd = "AutoInst",
		},
	},

	-- python
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				pyright = {
					single_file_support = true,
					settings = {
						python = {
							analysis = {
								autoSearchPaths = true,
								diagnosticMode = "workspace",
								useLibraryCodeForTypes = true,
							},
						},
					},
				},
				-- ruff_lsp = {},
			},
		},
		setup = {
			ruff_lsp = function()
				require("util").on_attach(function(client, _)
					if client.name == "ruff_lsp" then
						-- Disable hover in favor of Pyright
						client.server_capabilities.hoverProvider = false
					end
				end)
			end,
		},
	},
	{
		"linux-cultist/venv-selector.nvim",
		cmd = "VenvSelect",
		opts = {},
		keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
	},

	-- yaml
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				yamlls = {
					settings = {
						shema = {
							["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
						},
					},
				},
			},
		},
	},

	-- toml
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				taplo = {},
			},
		},
	},

	-- nushell
	-- url: https://github.com/LhKipp/nvim-nu
	{
		"LhKipp/nvim-nu",
		build = ":TSInstall nu",
	},
}
