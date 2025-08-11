local keymap = require("vim.keymap")
return {
	{
		"smoka7/hop.nvim",
		opts = {
			keys = "etovxqpdygfblzhckisuran",
		},
		keys = {
			{ "s", "<cmd>HopWord<CR>", desc = "Hop to any word" },
		},
	},
}
