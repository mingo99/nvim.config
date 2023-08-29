return {
	-- lua
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "lua", "luadoc", "luap" })
			end
		end,
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
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "json", "json5", "jsonc" })
			end
		end,
	},
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
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "verilog" })
			end
		end,
	},
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
					},
					settings = {
						verilog = {
							format = {
								-- indentation_spaces = vim.o.shiftwidth,
								indentation_spaces = 4,
								convertTabsToSpaces = vim.o.expandtab,
								tabSize = vim.o.tabstop,
							},
						},
					},
				},
			},
		},
	},

	-- make
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "make" })
			end
		end,
	},

	-- python
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "ninja", "python", "rst", "toml" })
			end
		end,
	},
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
				ruff_lsp = {},
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
}
