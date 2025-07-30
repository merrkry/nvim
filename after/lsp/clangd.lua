---@type vim.lsp.Config
return {
	cmd = {
		"clangd",
		"--enable-config",
		"--fallback-style=Google",
	},
}
