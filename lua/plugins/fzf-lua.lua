return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- or if using mini.icons/mini.nvim
	-- dependencies = { "echasnovski/mini.icons" },
	opts = {},
	keys = {
		{ '<leader>f', '<cmd>FzfLua files<cr>', desc = "Find files" },
		{ '<leader>/', '<cmd>FzfLua live_grep_native<cr>',  desc = "Search files" }
	},
}
