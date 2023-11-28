-- Reference options: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

-- Truecolor support
opt.termguicolors = true

-- Enable number and relativenumber of line
opt.relativenumber = true
opt.number = true

-- Indent
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- cursorline
opt.cursorline = true

-- Open mouse opration
opt.mouse:append("a")

-- Communication with system clipboard
opt.clipboard:append("unnamedplus")

-- New window will be on right an down
opt.splitright = true
opt.splitbelow = true

-- For search
-- opt.ignorecase = true
opt.smartcase = true

-- Fold code
opt.foldmethod = "indent"
opt.foldlevel = 99
