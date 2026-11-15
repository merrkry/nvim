local ui = require("config.ui")

---@type LazySpec
return {
	{
		"julienvincent/hunk.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		cmd = { "DiffEditor" },
		opts = {
			ui = {
				tree = {
					width = ui.sidebar_width,
				},
				layout = "vertical",
			},
		},
	},
}
