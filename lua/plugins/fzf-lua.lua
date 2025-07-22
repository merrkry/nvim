return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	-- dependencies = { "nvim-tree/nvim-web-devicons" },
	-- or if using mini.icons/mini.nvim
	dependencies = { "echasnovski/mini.nvim" },
	opts = {
		winopts = {
			preview = {
				default = "bat_native",
			},
		},
	},
	keys = {
		{
			"<leader>f",
			function()
				require("fzf-lua").global()
			end,
			desc = "Find files",
		},
		{
			"<leader>/",
			function()
				require("fzf-lua").live_grep_native()
			end,
			desc = "Search files",
		},
		{
			"<leader>?",
			function()
				require("fzf-lua").keymaps()
			end,
			desc = "Search keymaps",
		},
	},
}
