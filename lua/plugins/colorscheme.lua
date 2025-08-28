return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "frappe",
				transparent_background = true,
				no_italic = true,
				auto_integrations = true,
			})
			vim.cmd("colorscheme catppuccin")

			-- semantic highlighting on comments sometimes mess up with todo comments
			vim.api.nvim_set_hl(0, "@lsp.type.comment", {})
		end,
	},
}
