return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "echasnovski/mini.nvim" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "onedark",
				},
				sections = {
					lualine_c = {
						"%=",
						{
							"harpoon2",
							-- set non-nil value to overwrite the default options
							icon = "",
							separator = { left = "|", right = "|" },
							indicators = { "1", "2", "3", "4", "5", "6", "7", "8", "9" },
							active_indicators = { "[1]", "[2]", "[3]", "[4]", "[5]", "[6]", "[7]", "[8]", "[9]" },
						},
					},
				},
			})
		end,
	},
}
