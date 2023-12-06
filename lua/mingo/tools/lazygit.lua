local Util = require("mingo.util")
local Terminal = require("toggleterm.terminal").Terminal
local float_border_hl = vim.api.nvim_get_hl(0, { name = "FloatBorder" })

local M = {}

function M.lazygit_toggle()
	local lazygit = Terminal:new({
		cmd = "lazygit",
		dir = "git_dir",
		direction = "float",
		hidden = true,
		highlights = {
			FloatBorder = {
				guifg = float_border_hl.fg,
			},
		},
		float_opts = {
			border = "rounded",
			height = math.floor(vim.o.lines * 0.9),
		},
	})
	lazygit:toggle()
	Util.set_esc_ctrl_hjkl_false()
end

return M
