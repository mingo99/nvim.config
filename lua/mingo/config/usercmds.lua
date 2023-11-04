-- Add any autocmds here

local function set_esc_ctrl_hjkl_false()
	vim.keymap.set("t", "<esc>", "<esc>", { buffer = 0, nowait = true })
	vim.keymap.set("t", "<c-h>", "<c-h>", { buffer = 0, nowait = true })
	vim.keymap.set("t", "<c-j>", "<c-j>", { buffer = 0, nowait = true })
	vim.keymap.set("t", "<c-k>", "<c-k>", { buffer = 0, nowait = true })
	vim.keymap.set("t", "<c-l>", "<c-l>", { buffer = 0, nowait = true })
end

-- Create Lazugit,Joshuto with custom toggleterm
local Terminal = require("toggleterm.terminal").Terminal
local float_border_hl = vim.api.nvim_get_hl_by_name("FloatBorder", true)
local fg_color = float_border_hl.foreground
local bg_color = float_border_hl.background

local function lazygit_toggle()
	local lazygit = Terminal:new({
		cmd = "lazygit",
		dir = "git_dir",
		direction = "float",
		hidden = true,
		highlights = {
			FloatBorder = {
				guifg = fg_color,
				guibg = bg_color,
			},
		},
		float_opts = {
			border = "rounded",
		},
	})
	---@diagnostic disable-next-line: lowercase-global
	lazygit:toggle()
	set_esc_ctrl_hjkl_false()
end

vim.api.nvim_create_user_command("Lazygit", function()
	lazygit_toggle()
end, { nargs = 0 })

local function joshuto_toggle()
	local joshuto = Terminal:new({
		cmd = "joshuto",
		dir = vim.loop.cwd(),
		direction = "float",
		hidden = true,
		highlights = {
			FloatBorder = {
				guifg = fg_color,
				guibg = bg_color,
			},
		},
		float_opts = {
			border = "rounded",
		},
	})
	---@diagnostic disable-next-line: lowercase-global
	joshuto:toggle()
	set_esc_ctrl_hjkl_false()
end

vim.api.nvim_create_user_command("Joshuto", function()
	joshuto_toggle()
end, { nargs = 0 })
