---@type LazySpec
return {
	{
		"tpope/vim-sleuth",
		event = require("config.events").lazy_file,
		cond = not vim.g.vscode,
	},
}
