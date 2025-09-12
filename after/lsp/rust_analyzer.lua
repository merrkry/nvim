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
		-- doesn't seem to work
		-- rustfmt = {
		-- 	extraArgs = {
		-- 		"--unstable-features",
		-- 	},
		-- 	rangeFormatting = { enable = true },
		-- },
	},
}
