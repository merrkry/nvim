return {
	{
		"nvim-treesitter/nvim-treesitter",
		-- https://github.com/OXY2DEV/markview.nvim?tab=readme-ov-file#-lazynvim
		dependencies = { "OXY2DEV/markview.nvim" },
		branch = 'master', -- TODO: migrate to main
		lazy = false,
		build = ":TSUpdate",
		main = 'nvim-treesitter.configs',
		opts = {
			auto_install = true,
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				--  If you are experiencing weird indenting issues, add the language to
				--  the list of additional_vim_regex_highlighting and disabled languages for indent.
				additional_vim_regex_highlighting = { 'ruby' },
			},
			indent = { enable = true, disable = { 'ruby' } },
		},
	}
}
