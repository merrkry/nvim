---@type LazySpec
return {
	{
		"nvim-treesitter/nvim-treesitter-context",
		cond = not vim.g.vscode,
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = require("config.events").lazy_file,
		opts = {
			max_lines = 8,
			min_window_height = 32,
			multiline_threshold = 4,
		},
	},
}
