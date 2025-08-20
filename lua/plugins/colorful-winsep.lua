return {
	{
		"nvim-zh/colorful-winsep.nvim",
		event = { "WinLeave" },
		config = function()
			require("colorful-winsep").setup({
				highlight = "#e5c07b",
				animate = {
					enabled = false,
				},
			})
		end,
	},
}
