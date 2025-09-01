---@type vim.lsp.Config
return {
	init_options = {
		check = {
			command = "clippy",
			extraArgs = {
				"--",
				"-W",
				"clippy::pedantic",
				-- "-W",
				-- "clippy::restriction",
				"-W",
				"clippy::nursery",
				"-W",
				"clippy::cargo",
			},
		},
	},
}
