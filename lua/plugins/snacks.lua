return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			dashboard = {
				enable = true,
			},
			image = {
				enable = true,
				math = {
					enabled = false,
				},
			},
		},
		keys = {
		},
	},
}
