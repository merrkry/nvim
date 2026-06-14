local platform = require("kernel.platform")

local M = {
	{ import = "plugins.mini" },
	{ import = "plugins.snacks" },

	{ import = "plugins.edit" },
	{ import = "plugins.treesitter" },
}

if not platform.is_profile(platform.PROFILE.VSCODE) then
	vim.list_extend(M, {
		{ import = "plugins.ai" },
		{ import = "plugins.lang" },
		{ import = "plugins.lsp" },
		{ import = "plugins.tools" },
		{ import = "plugins.ui" },
		{ import = "plugins.vcs" },
	})
end

return M
