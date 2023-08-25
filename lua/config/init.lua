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

-- load plugins
-- path: ~/.config/nvim/lua/plugins
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")

-- Colorscheme
vim.cmd([[colorscheme tokyonight]])
-- vim.cmd([[colorscheme catppuccin]])
-- vim.cmd([[colorscheme darkplus]])
-- vim.cmd([[colorscheme onedark]])

require("config.usercmds")
require("config.autocmds")
require("config.options")
require("config.keymaps")
