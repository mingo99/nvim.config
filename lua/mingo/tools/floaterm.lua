local Util = require("mingo.util")
local Terminal = require("toggleterm.terminal").Terminal
local float_border_hl = vim.api.nvim_get_hl(0, { name = "FloatBorder" })

local M = {}

function M.floaterm_toggle(dir)
	local floaterm = Terminal:new({
		title = "Floaterm",
		dir = (dir == "cwd") and vim.fn.expand("%:p:h") or nil,
		direction = "float",
		highlights = {
			FloatBorder = {
				guifg = float_border_hl.fg,
			},
		},
		float_opts = {
			border = "rounded",
		},
	})
	floaterm:toggle()
	Util.set_esc_ctrl_hjkl_false()
end

return M
