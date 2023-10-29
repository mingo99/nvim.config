-- search/replace in multiple files
-- url: https://github.com/nvim-pack/nvim-spectre
return {
	"nvim-pack/nvim-spectre",
	cmd = "Spectre",
	opts = { open_cmd = "noswapfile vnew" },
        -- stylua: ignore
        keys = {
            { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
        },
}
