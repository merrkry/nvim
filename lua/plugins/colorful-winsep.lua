return {
	{
		"nvim-zh/colorful-winsep.nvim",
		event = { "WinLeave" },
		config = function()
			require("colorful-winsep").setup({
				highlight = {
					fg = "#e5c07b",
				},
				animate = {
					enabled = false,
				},
			})
		end,
	},
}
