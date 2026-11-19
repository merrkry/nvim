---@type LazySpec
return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		event = require("config.events").lazy_file,
		config = function()
			local utils = require("utils.treesitter")

			utils.setup()

			utils.install_parsers({
				"bash",
				"comment",
				"diff",
				"lua",
				"luadoc",
				"query",
				"regex",
				"vim",
				"vimdoc",
			})
		end,
	},
}
