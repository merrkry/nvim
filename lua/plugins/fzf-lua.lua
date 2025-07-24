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
			"<leader> ",
			function()
				require("fzf-lua").global()
			end,
			desc = "Open global picker",
		},
		{
			"<leader>f",
			function()
				require("fzf-lua").files()
			end,
			desc = "Open file picker",
		},
		{
			"<leader>B",
			function()
				require("fzf-lua").buffers()
			end,
			desc = "Open buffer picker",
		},
		{
			"<leader>/",
			function()
				require("fzf-lua").live_grep_native()
			end,
			desc = "Search with ripgrep",
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
