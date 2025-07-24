return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			image = {
				enabled = true,
				math = {
					enabled = false,
				},
			},
			input = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			statuscolumn = { enabled = true },
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
