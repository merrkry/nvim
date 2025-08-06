local keymap = require("vim.keymap")
return {
	{
		"phaazon/hop.nvim",
		version = "*",
		opts = {
			keys = "etovxqpdygfblzhckisuran",
		},
		keys = {
			{ "s", "<cmd>HopWord<CR>", desc = "Hop to any word" },
		},
	},
}
