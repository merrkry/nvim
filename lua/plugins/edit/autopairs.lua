local platform = require("kernel.platform")

---@type LazySpec
return {
	{
		"windwp/nvim-autopairs",
		cond = not platform.is_profile(platform.PROFILE.VSCODE),
		event = "InsertEnter",
		config = true,
	},
}
