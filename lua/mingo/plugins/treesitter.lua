-- treesitter is a new parser generator tool that we can use in Neovim to power faster and more accurate syntax highlighting
-- url: https://github.com/nvim-treesitter/nvim-treesitter
return {
	"nvim-treesitter/nvim-treesitter",
	version = false, -- last release is way too old and doesn't work on Windows
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			init = function()
				-- disable rtp plugin, as we only need its queries for mini.ai
				-- In case other textobject modules are enabled, we will load them
				-- once nvim-treesitter is loaded
				require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
				load_textobjects = true
			end,
		},
	},
	cmd = { "TSUpdateSync" },
	keys = {
		{ "<c-space>", desc = "Increment selection" },
		{ "<bs>", desc = "Decrement selection", mode = "x" },
	},
	---@type TSConfig
	opts = {
		modules = {},
		highlight = { enable = true },
		indent = { enable = true },
		ensure_installed = {
			"bash",
			"c",
			"html",
			"javascript",
			"jsdoc",
			"markdown",
			"markdown_inline",
			"query",
			"regex",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			"yaml",
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-space>",
				node_incremental = "<C-space>",
				scope_incremental = false,
				node_decremental = "<bs>",
			},
		},
		sync_install = false,
		auto_install = true,
		ignore_install = { "javascript" },
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					-- You can optionally set descriptions to the mappings (used in the desc parameter of
					-- nvim_buf_set_keymap) which plugins like which-key display
					["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
					-- You can also use captures from other query groups like `locals.scm`
					["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
				},
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
					["@class.outer"] = "<c-v>", -- blockwise
				},
				include_surrounding_whitespace = true,
			},
		},
	},
	---@param opts TSConfig
	config = function(_, opts)
		if type(opts.ensure_installed) == "table" then
			---@type table<string, boolean>
			local added = {}
			opts.ensure_installed = vim.tbl_filter(function(lang)
				if added[lang] then
					return false
				end
				added[lang] = true
				return true
			end, opts.ensure_installed)
		end
		require("nvim-treesitter.configs").setup(opts)

		if load_textobjects then
			-- PERF: no need to load the plugin, if we only need its queries for mini.ai
			if opts.textobjects then
				for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
					if opts.textobjects[mod] and opts.textobjects[mod].enable then
						local Loader = require("lazy.core.loader")
						Loader.disabled_rtp_plugins["nvim-treesitter-textobjects"] = nil
						local plugin = require("lazy.core.config").plugins["nvim-treesitter-textobjects"]
						require("lazy.core.loader").source_runtime(plugin.dir, "plugin")
						break
					end
				end
			end
		end
	end,
}
