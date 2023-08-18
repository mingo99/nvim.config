return{ 
    -- helps you remember key bindings by showing a popup
    -- url: https://github.com/folke/which-key.nvim
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
         	vim.o.timeout = true
         	vim.o.timeoutlen = 300
        end,
        opts = {}
    },
}
