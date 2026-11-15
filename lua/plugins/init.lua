local M = {
	{ import = "plugins.mini" },

	{ import = "plugins.edit" },
	{ import = "plugins.treesitter" },
}

if not vim.g.vscode then
	vim.list_extend(M, {
		{ import = "plugins.local" },
		{ import = "plugins.snacks" },
		{ import = "plugins.lang" },
		{ import = "plugins.lsp" },
		{ import = "plugins.tools" },
		{ import = "plugins.ui" },
		{ import = "plugins.vcs" },
	})
end

return M
