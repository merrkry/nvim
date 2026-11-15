return {
	{
		ft = { "json", "jsonc" },
		lsp = { "jsonls" },
		formatters = { "oxfmt" },
		lineWidth = 100,
	},
	{
		ft = { "markdown", "yaml" },
		formatters = { "oxfmt" },
		lineWidth = 100,
	},
	{
		ft = { "kdl" },
		formatters = { "kdlfmt" },
	},
	{
		ft = { "toml" },
		lsp = { "taplo" },
		formatters = { "taplo" },
	},
}
