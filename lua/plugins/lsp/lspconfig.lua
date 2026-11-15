---@type LazySpec
return {
	{
		"neovim/nvim-lspconfig",
		event = "FileType",
		dependencies = { "lsp-progress.nvim" },
		config = require("utils.lsp").setup_lsp,
	},
}
