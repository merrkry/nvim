local ui = require("config.ui")

---@type LazySpec
return {
	{
		"XXiaoA/atone.nvim",
		cmd = "Atone",
		opts = {
			layout = {
				direction = "right",
				width = ui.sidebar_width,
			},
			ui = {
				compact = true,
			},
		},
		keys = {
			{ "<leader>u", "<cmd>Aton toggle<cr>", desc = "Open undotree" },
		},
	},
}
