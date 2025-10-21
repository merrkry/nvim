return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "frappe",
				transparent_background = true,
				-- no_italic = true,
				styles = {
					comments = {},
				},
				auto_integrations = true,
			})
			vim.cmd("colorscheme catppuccin")
		end,
	},
}
