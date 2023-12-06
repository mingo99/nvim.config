local Util = require("mingo.util")
local Terminal = require("toggleterm.terminal").Terminal
local float_border_hl = vim.api.nvim_get_hl(0, { name = "FloatBorder" })

local M = {}

local function OpenFile(tempname)
	if vim.fn.filereadable(vim.fn.expand(tempname)) == 1 then
		local filenames = vim.fn.readfile(tempname)
		for _, filename in ipairs(filenames) do
			vim.cmd(string.format(":edit %s", filename))
		end
	end
end

function M.yazi_toggle()
	local prev_win = vim.api.nvim_get_current_win()
	local tempname = vim.fn.tempname()

	local yazi = Terminal:new({
		title = "Yazi",
		cmd = "yazi --chooser-file " .. tempname,
		dir = vim.loop.cwd(),
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
		on_exit = function()
			vim.api.nvim_set_current_win(prev_win)
			OpenFile(tempname)
			vim.cmd([[startinsert]])
			vim.fn.delete(tempname)
		end,
	})
	yazi:toggle()
	Util.set_esc_ctrl_hjkl_false()
end

return M
