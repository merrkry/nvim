return {
	"HiPhish/rainbow-delimiters.nvim",
	config = function()
		require("rainbow-delimiters.setup").setup({
			highlight = {
				"RainbowDelimiterRed",
				"RainbowDelimiterOrange",
				"RainbowDelimiterYellow",
				"RainbowDelimiterGreen",
				"RainbowDelimiterCyan",
				"RainbowDelimiterBlue",
				"RainbowDelimiterViolet",
			},
		})
	end,
}
