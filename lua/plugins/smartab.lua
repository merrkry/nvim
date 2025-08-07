return {
	{
		"parsifa1/smartab.nvim",
		event = "InsertEnter",
		opts = {
			skips = { "string_content" },
			mapping = "<tab>",
			backward_mapping = "<S-tab>",
			behavior = "nested",
			pairs = {
				{ open = "(", close = ")" },
				{ open = "[", close = "]" },
				{ open = "{", close = "}" },
				{ open = "<", close = ">" },
				{ open = "'", close = "'" },
				{ open = '"', close = '"' },
				{ open = "`", close = "`" },
			},
			exclude_filetype = {},
		},
	},
}
