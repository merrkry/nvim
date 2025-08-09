return {
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		-- dependencies = { "nvim-tree/nvim-web-devicons" },
		-- or if using mini.icons/mini.nvim
		dependencies = { "echasnovski/mini.nvim" },
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
				"<leader>b",
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
		config = function()
			require("fzf-lua").setup({ "fzf-native" })

			require("fzf-lua").register_ui_select()
		end,
	},
}
