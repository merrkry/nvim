return {
	-- "OXY2DEV/markview.nvim",
	-- lazy = false,
	--
	-- -- For `nvim-treesitter` users.
	-- priority = 49,
	--
	-- -- For blink.cmp's completion source
	-- dependencies = {
	-- 	"saghen/blink.cmp"
	-- },
	{
		'MeanderingProgrammer/render-markdown.nvim',
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			-- enabled = false,
			render_modes = true,
			latex = {
				enabled = false,
			},
		},
		-- config = function()
		-- 	require('render-markdown').setup({
		-- 		render_modes = true,
		-- 		latex = { enabled = false },
		-- 	})
		-- end,
	}
};
