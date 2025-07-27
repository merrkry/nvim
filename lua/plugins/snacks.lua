return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = {},
			dashboard = {
				sections = {
					{ section = "header" },
					{
						-- pane = 2,
						icon = " ",
						title = "Git Status",
						section = "terminal",
						enabled = function()
							return Snacks.git.get_root() ~= nil
						end,
						cmd = "git status --short --branch --renames",
					},
					{ section = "startup" },
				},
			},
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
