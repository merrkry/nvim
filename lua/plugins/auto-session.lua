return {
	{
		"rmagatti/auto-session",
		lazy = false, -- opts.lazy_support
		opts = {
			auto_restore = true,
			-- only execute inside git directories
			auto_create = function()
				local cmd = "git rev-parse --is-inside-work-tree"
				return vim.fn.system(cmd) == "true\n"
			end,
			continue_restore_on_error = false, -- why is this true by default?
			purge_after_minutes = 20160, -- two weeks
		},
	},
}
