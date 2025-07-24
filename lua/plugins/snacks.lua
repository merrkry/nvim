return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = {},
			dashboard = {},
			image = {
				math = {
					enabled = false,
				},
			},
			indent = {},
			input = {},
			notifier = {},
			quickfile = {},
			statuscolumn = {},
		},
		keys = {
			{
				"<leader>n",
				function()
					require("snacks").notifier.show_history()
				end,
				desc = "Show notification history",
			},
		},
	},
}
