-- file explorer
-- url: https://github.com/nvim-neo-tree/neo-tree.nvim
return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	cmd = "NeoTree",
	keys = {
		{
			"<leader>fe",
			function()
				require("neo-tree.command").execute({ toggle = true, dir = require("mingo.util").get_root() })
			end,
			desc = "explorer neotree (root dir)",
		},
		{
			"<leader>fE",
			function()
				require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
			end,
			desc = "explorer neotree (cwd)",
		},
		{ "<leader>e", "<leader>fe", desc = "explorer neotree (root dir)", remap = true },
		{ "<leader>E", "<leader>fE", desc = "explorer neotree (cwd)", remap = true },
		{
			"<leader>ge",
			function()
				require("neo-tree.command").execute({ source = "git_status", toggle = true })
			end,
			desc = "Git Explorer",
		},
		{
			"<leader>be",
			function()
				require("neo-tree.command").execute({ source = "buffers", toggle = true })
			end,
			desc = "Buffer Explorer",
		},
	},
	deactivate = function()
		vim.cmd([[neotree close]])
	end,
	init = function()
		if vim.fn.argc() == 1 then
			local stat = vim.loop.fs_stat(tostring(vim.fn.argv(0)))
			if stat and stat.type == "directory" then
				require("neo-tree")
			end
		end
	end,
	opts = {
		close_if_last_window = false,
		popup_border_style = "rounded",
		sources = { "filesystem", "buffers", "git_status", "document_symbols" },
		open_files_do_not_replace_types = { "terminal", "trouble", "qf", "outline" },
		filesystem = {
			-- bind_to_cwd = false,
			bind_to_cwd = true,
			follow_current_file = { enabled = true },
			use_libuv_file_watcher = true,
			filtered_items = {
				visible = false, -- when true, they will just be displayed differently than normal items
				hide_dotfiles = true,
				hide_gitignored = false,
				hide_hidden = true, -- only works on Windows for hidden files/directories
				hide_by_name = {
					--"node_modules"
				},
				hide_by_pattern = { -- uses glob style patterns
					--"*.meta",
					--"*/src/*/tsconfig.json",
				},
				always_show = { -- remains visible even if other settings would normally hide it
					".gitignore",
				},
				never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
					--".DS_Store",
					--"thumbs.db"
				},
				never_show_by_pattern = { -- uses glob style patterns
					--".null-ls_*",
				},
			},
		},
		window = {
			width = 25,
			mappings = {
				["<space>"] = "none",
				["Y"] = {
					function(state)
						local node = state.tree:get_node()
						local path = node:get_id()
						vim.fn.setreg("+", path, "c")
					end,
					desc = "Copy Path to Clipboard",
				},
				["O"] = {
					function(state)
						require("lazy.util").open(state.tree:get_node().path, { system = true })
					end,
					desc = "Open with System Application",
				},
			},
		},
		default_component_configs = {
			indent = {
				indent_size = 2,
				with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
				expander_collapsed = "",
				expander_expanded = "",
				expander_highlight = "NeoTreeExpander",
			},
		},
		source_selector = {
			winbar = false,
			statusline = true,
		},
	},
	config = function(_, opts)
		require("neo-tree").setup(opts)
		vim.api.nvim_create_autocmd("termclose", {
			pattern = "*lazygit",
			callback = function()
				if package.loaded["neo-tree.sources.git_status"] then
					require("neo-tree.sources.git_status").refresh()
				end
			end,
		})
	end,
}
