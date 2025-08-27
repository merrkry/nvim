return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = {
			"echasnovski/mini.nvim",

			"AndreM222/copilot-lualine",
		},
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto",
				},
				sections = {
					lualine_x = { "copilot", "encoding", "filetype" },
				},
			})
		end,
	},
}
