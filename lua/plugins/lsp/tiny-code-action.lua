---@type LazySpec
return {
	{
		"rachartier/tiny-code-action.nvim",
		dependencies = { "folke/snacks.nvim" },
		event = "LspAttach",
		opts = {
			backend = "difftastic",
			picker = "snacks",
		},
		keys = {
			{
				"<leader>a",
				function()
					require("tiny-code-action").code_action()
				end,
				mode = { "n", "x" },
				desc = "Show code actions",
			},
		},
	},
}
