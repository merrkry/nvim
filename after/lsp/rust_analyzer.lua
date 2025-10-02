---@type vim.lsp.Config
return {
	init_options = {
		-- TODO: workspace-independent feature flags
		cargo = { features = "all" },
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
		diagnostics = { experimental = { enable = true } },
		-- inspired by Helix default
		inlayHints = {
			bindingModeHints = { enable = false },
			closingBraceHints = { minLines = 10 },
			closureReturnTypeHints = { enable = "with_block" },
			discriminantHints = { enable = "fieldless" },
			lifetimeElisionHints = { enable = "skip_trivial" },
			typeHints = { hideClosureInitialization = false },
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
