return {
	{
		'stevearc/oil.nvim',
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			delete_to_trash = true,
			watch_for_changes = true,
		},
		dependencies = { { "echasnovski/mini.nvim", opts = {} } },
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
		keys = {
			{ '<leader>e', '<cmd>Oil<cr>', desc = "File explorer" },
		},
	}
}
