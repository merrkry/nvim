---@type LazySpec
return {
	{
		"saghen/blink.pairs",
		version = "*",
		dependencies = { "saghen/blink.lib" },
		build = function()
			-- FIXME: https://github.com/saghen/blink.pairs/issues/112
			require("blink.pairs").build():pwait(60000)
		end,
		opts = {
			mappings = { enabled = false },
		},
	},
}
