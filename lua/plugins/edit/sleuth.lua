local platform = require("kernel.platform")

---@type LazySpec
return {
	{
		"tpope/vim-sleuth",
		event = "LazyFile",
		cond = not platform.is_profile(platform.PROFILE.VSCODE),
	},
}
