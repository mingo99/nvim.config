-- Add any autocmds here

local function set_esc_ctrl_hjkl_false()
	vim.keymap.set("t", "<esc>", "<esc>", { buffer = 0, nowait = true })
	vim.keymap.set("t", "<c-h>", "<c-h>", { buffer = 0, nowait = true })
	vim.keymap.set("t", "<c-j>", "<c-j>", { buffer = 0, nowait = true })
	vim.keymap.set("t", "<c-k>", "<c-k>", { buffer = 0, nowait = true })
	vim.keymap.set("t", "<c-l>", "<c-l>", { buffer = 0, nowait = true })
end

-- Run command with Floaterm
vim.api.nvim_create_user_command("FloatermCmd", function(opts)
	local args_str = opts.args
	local args = {}

	for arg in args_str:gmatch("%S+") do
		table.insert(args, arg)
	end

	assert((#args == 2), "Two arguments required")
	local cmd = string.format(
		"FloatermNew --cwd=%s --disposable --title=Joshuto --titleposition=center --height=0.9 --width=0.9 %s",
		args[2],
		args[1]
	)
	vim.cmd(cmd)
	set_esc_ctrl_hjkl_false()
end, { nargs = "+" })

-- Joshuto
vim.api.nvim_create_user_command("Joshuto", function(opts)
	local args = opts.args:match("%S+")
	local cmd = nil
	if args then
		cmd = "FloatermCmd joshuto " .. opts.args
	else
		cmd = "FloatermCmd joshuto <buffer>"
	end
	vim.cmd(cmd)
	set_esc_ctrl_hjkl_false()
end, { nargs = "?" })

-- Lazygit
vim.api.nvim_create_user_command("Lazygit", function(opts)
	local args = opts.args:match("%S+")
	local cmd = nil
	if args then
		cmd = "FloatermCmd lazygit " .. opts.args
	else
		cmd = "FloatermCmd lazygit <buffer>"
	end
	vim.cmd(cmd)
	set_esc_ctrl_hjkl_false()
end, { nargs = "?" })
