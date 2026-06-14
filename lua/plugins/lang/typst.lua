---@type LazySpec
return {
	{
		"chomosuke/typst-preview.nvim",
		ft = "typst",
		opts = {
			-- FIXME: "chromium" is Linux-specific; choose a Windows browser command when running there.
			open_cmd = "chromium --incognito --new-window %s",
			dependencies_bin = {
				["tinymist"] = "tinymist",
				["websocat"] = "websocat",
			},
		},
	},
}
