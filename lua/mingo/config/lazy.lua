-- map leader to <space>
vim.g.mapleader = " "

-- lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- load plugins
-- path: ~/.config/nvim/lua/plugins
local opts = {
	ui = {
		border = "rounded",
		title = "lazy.nvim",
	},
}
require("lazy").setup("mingo.plugins", opts)

-- Colorscheme
vim.cmd([[colorscheme tokyonight]])
-- vim.cmd([[colorscheme carbonfox]])

require("mingo.config.usercmds")
require("mingo.config.autocmds")
require("mingo.config.options")
require("mingo.config.keymaps")
