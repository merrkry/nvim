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
				server = {
					default_settings = {
						["rust-analyzer"] = vim.lsp.config["rust_analyzer"].init_options,
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
