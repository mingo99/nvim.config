return {
	-- auto completion
	-- url: https://github.com/hrsh7th/nvim-cmp
	{
		"hrsh7th/nvim-cmp",
		version = false, -- last release is way too old
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
		},
		opts = function()
			vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
			local cmp = require("cmp")
			local defaults = require("cmp.config.default")()
			return {
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<S-CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
				experimental = {
					ghost_text = {
						hl_group = "CmpGhostText",
					},
				},
				sorting = defaults.sorting,
			}
		end,
	},

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

	-- comment lines
	-- url: https://github.com/echasnovski/mini.comment
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		opts = {
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring()
						or vim.bo.commentstring
				end,
			},
		},
	},

	-- a neovim plugin for setting the commentstring option based on the cursor location in the file
	-- the location is checked via treesitter queries
	-- url: https://github.com/JoosepAlviste/nvim-ts-context-commentstring
	{ "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },

	-- indent guides for Neovim
	-- url: indent guides for Neovim
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			-- char = "▏",
			char = "│",
			filetype_exclude = {
				"help",
				"alpha",
				"dashboard",
				"neo-tree",
				"Trouble",
				"lazy",
				"mason",
				"notify",
				"toggleterm",
				"lazyterm",
			},
			use_treesitter = true,
			show_trailing_blankline_indent = false,
			show_current_context = false,
		},
	},

	-- active indent guide and indent text objects
	-- url: https://github.com/echasnovski/mini.indentscope
	{
		"echasnovski/mini.indentscope",
		version = false, -- wait till new 0.7.0 release to put it back on semver
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			-- symbol = "▏",
			symbol = "│",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},

	-- minimal and fast autopairs
	-- url: https://github.com/echasnovski/mini.pairs
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		opts = {},
	},

	-- fast and feature-rich surround actions
	-- url: https://github.com/echasnovski/mini.surround
	{
		"echasnovski/mini.surround",
		keys = function(_, keys)
			-- Populate the keys based on the user's options
			local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
			local opts = require("lazy.core.plugin").values(plugin, "opts", false)
			local mappings = {
				{ opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
				{ opts.mappings.delete, desc = "Delete surrounding" },
				{ opts.mappings.find, desc = "Find right surrounding" },
				{ opts.mappings.find_left, desc = "Find left surrounding" },
				{ opts.mappings.highlight, desc = "Highlight surrounding" },
				{ opts.mappings.replace, desc = "Replace surrounding" },
				{ opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
			}
			mappings = vim.tbl_filter(function(m)
				return m[1] and #m[1] > 0
			end, mappings)
			return vim.list_extend(mappings, keys)
		end,
		opts = {
			mappings = {
				add = "gza", -- Add surrounding in Normal and Visual modes
				delete = "gzd", -- Delete surrounding
				find = "gzf", -- Find surrounding (to the right)
				find_left = "gzF", -- Find surrounding (to the left)
				highlight = "gzh", -- Highlight surrounding
				replace = "gzr", -- Replace surrounding
				update_n_lines = "gzn", -- Update `n_lines`
			},
		},
	},

	-- better text-objects, extend and create a/i textobjects
	-- url: https://github.com/echasnovski/mini.ai
	{
		"echasnovski/mini.ai",
		-- keys = {
		--   { "a", mode = { "x", "o" } },
		--   { "i", mode = { "x", "o" } },
		-- },
		event = "VeryLazy",
		dependencies = { "nvim-treesitter-textobjects" },
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}, {}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
				},
			}
		end,
		config = function(_, opts)
			require("mini.ai").setup(opts)
			-- register all text objects with which-key
			require("util").on_load("which-key.nvim", function()
				---@type table<string, string|table>
				local i = {
					[" "] = "whitespace",
					['"'] = 'balanced "',
					["'"] = "balanced '",
					["`"] = "balanced `",
					["("] = "balanced (",
					[")"] = "balanced ) including white-space",
					[">"] = "balanced > including white-space",
					["<lt>"] = "balanced <",
					["]"] = "balanced ] including white-space",
					["["] = "balanced [",
					["}"] = "balanced } including white-space",
					["{"] = "balanced {",
					["?"] = "user prompt",
					_ = "underscore",
					a = "argument",
					b = "balanced ), ], }",
					c = "class",
					f = "function",
					o = "block, conditional, loop",
					q = "quote `, \", '",
					t = "tag",
				}
				local a = vim.deepcopy(i)
				for k, v in pairs(a) do
					a[k] = v:gsub(" including.*", "")
				end

				local ic = vim.deepcopy(i)
				local ac = vim.deepcopy(a)
				for key, name in pairs({ n = "next", l = "last" }) do
					i[key] = vim.tbl_extend("force", { name = "inside " .. name .. " textobject" }, ic)
					a[key] = vim.tbl_extend("force", { name = "around " .. name .. " textobject" }, ac)
				end
				require("which-key").register({
					mode = { "o", "x" },
					i = i,
					a = a,
				})
			end)
		end,
	},
}
