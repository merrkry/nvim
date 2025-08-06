return {
	{
		"nvim-zh/colorful-winsep.nvim",
		config = true,
		event = {
			"BufRead",
			"BufNewFile",
		},
		opts = { hi = { fg = "#e5c07b" } },
	},
}
