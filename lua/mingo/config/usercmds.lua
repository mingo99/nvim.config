-- Add any autocmds here

local function set_esc_ctrl_hjkl_false()
	vim.keymap.set("t", "<esc>", "<esc>", { buffer = 0, nowait = true })
	vim.keymap.set("t", "<c-h>", "<c-h>", { buffer = 0, nowait = true })
	vim.keymap.set("t", "<c-j>", "<c-j>", { buffer = 0, nowait = true })
	vim.keymap.set("t", "<c-k>", "<c-k>", { buffer = 0, nowait = true })
	vim.keymap.set("t", "<c-l>", "<c-l>", { buffer = 0, nowait = true })
end

-- Open joshuto with floaterm
vim.api.nvim_create_user_command("Joshuto", function(opts)
	local jso = string.format(
		"FloatermNew --cwd=%s --title=Joshuto --titleposition=center --height=0.9 --width=0.9 joshuto",
		opts.args
	)
	vim.cmd(jso)
	set_esc_ctrl_hjkl_false()
end, { nargs = 1 })

-- Open lazygit with floaterm
vim.api.nvim_create_user_command("Lazygit", function(opts)
	local lg = string.format(
		"FloatermNew --cwd=%s --title=Lazygit --titleposition=center --height=0.9 --width=0.9 lazygit",
		opts.args
	)
	vim.cmd(lg)
	set_esc_ctrl_hjkl_false()
end, { nargs = 1 })
