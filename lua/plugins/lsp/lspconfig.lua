---@type LazySpec
return {
	{
		"neovim/nvim-lspconfig",
		event = "FileType",
		dependencies = { "mason-org/mason.nvim" },
		config = function()
			require("config.lsp").setup()
		end,
	},
}
