return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
	},
	{
		"MeanderingProgrammer/treesitter-modules.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			ensure_installed = {
				"bash",
				"comment",
				"diff",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"regex",
				"rust",
				"vim",
				"vimdoc",
			},
			auto_install = true,
			fold = { enable = false },
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = { enable = false },
		},
	},
	{
		"yorickpeterse/nvim-tree-pairs",
		event = "VeryLazy",
		opts = {},
	},
}
