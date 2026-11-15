-- Resolve from this spec so deployments and development worktrees use their own plugins.
local root = vim.fs.dirname(vim.fs.dirname(vim.fs.dirname(assert(debug.getinfo(1, "S")).source:sub(2))))

---@type LazySpec
return {
	{
		dir = root .. "/local/wrap-guides.nvim",
		main = "wrap_guides",
		lazy = false,
		opts = {
			widths = function(buf)
				local config = require("lang").by_ft()[vim.bo[buf].filetype]
				return config and config.lineWidth or 100
			end,
		},
	},
	{
		dir = root .. "/local/lsp-progress.nvim",
		main = "lsp_progress",
		lazy = false,
		opts = {},
	},
}
