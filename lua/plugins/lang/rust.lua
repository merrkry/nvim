return {
	{
		"mrcjkb/rustaceanvim",
		version = "*",
		ft = { "rust" },
		config = function()
			vim.g.rustaceanvim = {
				tools = {
					float_win_config = {
						border = vim.o.winborder,
					},
				},
			}
		end,
	},
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		tag = "stable",
		config = function()
			require("crates").setup({
				lsp = {
					enabled = true,
					actions = true,
					completion = true,
					hover = true,
				},
			})
		end,
	},
}
