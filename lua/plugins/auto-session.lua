return {
	{
		"rmagatti/auto-session",
		lazy = false, -- opts.lazy_support
		opts = {
			-- only execute inside git directories
			auto_create = function()
				local cmd = "git rev-parse --is-inside-work-tree"
				return vim.fn.system(cmd) == "true\n"
			end,
			lsp_stop_on_restore = true,
			purge_after_minutes = 20160, -- two weeks
		},
	},
}
