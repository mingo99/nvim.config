-- better text-objects, extend and create a/i textobjects
-- url: https://github.com/echasnovski/mini.ai
return {
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
		require("mingo.util").on_load("which-key.nvim", function()
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
}
