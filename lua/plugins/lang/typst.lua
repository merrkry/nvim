---@type LazySpec
return {
	{
		"chomosuke/typst-preview.nvim",
		ft = "typst",
		opts = {
			open_cmd = vim.fn.executable("chromium") == 1 and "chromium --incognito --new-window %s" or nil,
			dependencies_bin = {
				["tinymist"] = "tinymist",
				["websocat"] = "websocat",
			},
		},
	},
}
