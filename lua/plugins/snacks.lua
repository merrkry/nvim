return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = {
				enabled = true,
			},
			dashboard = {
				enabled = true,
			},
			image = {
				enabled = true,
				math = {
					enabled = false,
				},
			},
			notifier = {
				enabled = true,
			},
			quickfile = {
				enabled = true,
			},
		},
		keys = {
			{ "<leader>n", function() require("snacks").notifier.show_history() end, desc = "Show notification history" },
		},
	},
}
