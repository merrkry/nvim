---@type LazySpec
return {
	{
		"chrisgrieser/nvim-early-retirement",
		event = "VeryLazy",
		opts = {
			retirementAgeMins = 30,
			minimumBufferNum = 4,
			-- FIXME: when opening filenames that don't exist yet,
			-- early-retirement closes the buffer shortly after nvim launch,
			-- before we have a chance to edit and save it.
			deleteBufferWhenFileDeleted = false,
		},
	},
}
