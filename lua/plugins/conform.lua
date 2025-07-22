return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				json = { "prettier" },
				yaml = { "prettier" },
			},
			default_format_opts = {
				lsp_format = "first",
			},
		},
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format()
				end,
				desc = "Format buffer",
			},
		},
	},
}
