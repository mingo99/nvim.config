local Floaterm = require("mingo.tools.floaterm")
local Lazygit = require("mingo.tools.lazygit")
local Yazi = require("mingo.tools.yazi")

-- Add any autocmds here

vim.api.nvim_create_user_command("Lazygit", function()
	Lazygit.lazygit_toggle()
end, { nargs = 0 })

vim.api.nvim_create_user_command("Yazi", function()
	Yazi.yazi_toggle()
end, { nargs = 0 })

vim.api.nvim_create_user_command("Floaterm", function(opts)
	Floaterm.floaterm_toggle(opts.args)
end, { nargs = "?" })
