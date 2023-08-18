return {
    -- treesitter is a new parser generator tool that we can use in Neovim to power faster and more accurate syntax highlighting
    -- url: https://github.com/nvim-treesitter/nvim-treesitter
    { 
        "nvim-treesitter/nvim-treesitter",
        version = false, -- last release is way too old and doesn't work on Windows
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                'JoosepAlviste/nvim-ts-context-commentstring',
            },
        },
        cmd = { "TSUpdateSync" },
        keys = {
            { "<c-space>", desc = "Increment selection" },
            { "<bs>", desc = "Decrement selection", mode = "x" },
        },
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = {
                    "bash",
                    "c", 
                    "json",
                    "lua", 
                    "markdown",
                    "python",
                    "query",
                    "vim", 
                    "vimdoc", 
                    "verilog", 
                },
                sync_install = false,
                auto_install = true,
                --ignore_install = { "javascript" },
                highlight = {
                    enable = true,
                    disable = { "c", "rust" },
                    disable = function(lang, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                    additional_vim_regex_highlighting = false,
                },
                -- for nvim-ts-context-commentstring
                context_commentstring = {
                    enable = true,
                },
            }
        end 
    },
}
