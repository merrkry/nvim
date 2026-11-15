---@type LazySpec
return {
	{
		"max397574/better-escape.nvim",
		cond = not vim.g.vscode,
		opts = {
			timeout = 100,
			default_mappings = false,
			mappings = {
				-- insert
				i = {
					j = {
						k = "<Esc>",
					},
				},
				-- terminal
				t = {
					j = {
						k = "<C-\\><C-n>",
					},
				},
			},
		},
	},
}
