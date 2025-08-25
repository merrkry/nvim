return {
	{
		"chrisgrieser/nvim-spider",
		lazy = true,
		opts = {
			subwordMovement = false,
			skipInsignificantPunctuation = true,
		},
		keys = {
			{ "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
			{ "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
			{ "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
			{ "<C-f>", "<cmd>lua require('spider').motion('w')<CR>", mode = { "i" } },
			{ "<C-b>", "<cmd>lua require('spider').motion('b')<CR>", mode = { "i" } },
		},
	},
}
