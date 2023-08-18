return {
    -- git signs highlights text that has changed since the list git commit, and also lets you interactively stage & unstage hunks in a commit
    -- url: https://github.com/lewis6991/gitsigns.nvim
    {
     	"lewis6991/gitsigns.nvim",
     	event = { "bufreadpre", "bufnewfile" },
     	opts = {
     	 	signs = {
     	 	 	add = { text = "▎" },
     	 	 	change = { text = "▎" },
     	 	 	delete = { text = "" },
     	 	 	topdelete = { text = "" },
     	 	 	changedelete = { text = "▎" },
     	 	 	untracked = { text = "▎" },
     	 	},
     	 	on_attach = function(buffer)
     	 	 	local gs = package.loaded.gitsigns
    
     	 	 	local function map(mode, l, r, desc)
     	 	 	    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
     	 	 	end
    
     	 	 	-- stylua: ignore start
     	 	 	map("n", "]h", gs.next_hunk, "next hunk")
     	 	 	map("n", "[h", gs.prev_hunk, "prev hunk")
     	 	 	map({ "n", "v" }, "<leader>ghs", ":gitsigns stage_hunk<cr>", "stage hunk")
     	 	 	map({ "n", "v" }, "<leader>ghr", ":gitsigns reset_hunk<cr>", "reset hunk")
     	 	 	map("n", "<leader>ghs", gs.stage_buffer, "stage buffer")
     	 	 	map("n", "<leader>ghu", gs.undo_stage_hunk, "undo stage hunk")
     	 	 	map("n", "<leader>ghr", gs.reset_buffer, "reset buffer")
     	 	 	map("n", "<leader>ghp", gs.preview_hunk, "preview hunk")
     	 	 	map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "blame line")
     	 	 	map("n", "<leader>ghd", gs.diffthis, "diff this")
     	 	 	map("n", "<leader>ghd", function() gs.diffthis("~") end, "diff this ~")
     	 	 	map({ "o", "x" }, "ih", ":<c-u>gitsigns select_hunk<cr>", "gitsigns select hunk")
     	 	end,
     	},
    }
}
