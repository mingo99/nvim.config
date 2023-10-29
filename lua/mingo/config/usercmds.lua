-- Add any autocmds here

-- Open joshuto with floaterm
vim.api.nvim_create_user_command("Joshuto", "FloatermNew --title=Joshuto --height=0.9 --width=0.9 joshuto", {})
