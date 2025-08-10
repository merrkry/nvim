return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				css = { "prettier" },
				lua = { "stylua" },
				markdown = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				["_"] = { "trim_whitespace" },
			},
			default_format_opts = {
				lsp_format = "first",
			},
		},
		keys = {
			{
				"<leader>l",
				function()
					require("conform").format()
				end,
				mode = { "n", "x" },
				desc = "Format buffer",
			},
		},
	},
}
