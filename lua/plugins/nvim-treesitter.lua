return {
	{
		"nvim-treesitter/nvim-treesitter",
		-- https://github.com/OXY2DEV/markview.nvim?tab=readme-ov-file#-lazynvim
		branch = "master", -- TODO: migrate to main
		lazy = false,
		build = ":TSUpdate",
		main = "nvim-treesitter.configs",
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				highlight = {
					enable = true,
					-- FIXME: This doesn't take effect.
					ensure_installed = {
						"bash",
						"diff",
						"lua",
						"luadoc",
						"markdown",
						"markdown_inline",
						"query",
						"regex",
						"vim",
						"vimdoc",
					},
					-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
					--  If you are experiencing weird indenting issues, add the language to
					--  the list of additional_vim_regex_highlighting and disabled languages for indent.
					additional_vim_regex_highlighting = { "ruby" },
				},
				indent = { enable = true, disable = { "ruby" } },
			})
		end,
	},
}
