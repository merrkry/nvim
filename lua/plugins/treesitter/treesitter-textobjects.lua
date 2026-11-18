---@type LazySpec
return {
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		-- mini.ai reads this plugin's textobjects queries directly.
		event = require("config.events").lazy_file,
	},
}
