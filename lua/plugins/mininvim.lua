-- select useful tools in mini,nvim
-- url: https://github.com/echasnovski/mini.nvim
return {
    -- autopairs
    {
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        opts = {},
    },
    -- Fast and feature-rich surround actions
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
    -- Better comment 
    {
     	"echasnovski/mini.comment",
     	event = "VeryLazy",
     	opts = {
     	 	options = {
     	 	 	custom_commentstring = function()
     	 	 	    return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
     	 	 	end,
     	 	},
     	},
    },
    -- Better text-objects 
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
    -- buffer remove
    {
     	"echasnovski/mini.bufremove",
     	-- stylua: ignore
     	keys = {
     	 	{ "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
     	 	{ "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
     	},
    },
}
