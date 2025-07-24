return {
	{
		"leath-dub/snipe.nvim",
		keys = {
			{
				"<leader>b",
				function()
					require("snipe").open_buffer_menu()
				end,
				desc = "Open Snipe buffer menu",
			},
		},
		config = function()
			require("snipe").setup({
				ui = {
					position = "center",
					open_win_override = { border = "rounded", title_pos = "center" },
					preselect_current = true,
					sort = "last",
				},
			})
			vim.api.nvim_set_hl(0, "NormalFloat", { fg = "none", bg = "none" })
			vim.api.nvim_set_hl(0, "FloatBorder", { fg = "none", bg = "none" })
		end,
	},
}
