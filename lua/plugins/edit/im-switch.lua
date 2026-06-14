---@type LazySpec
return {
	{
		"drop-stones/im-switch.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		opts = {
			-- FIXME: Add Windows input-method commands or disable this plugin on Windows.
			linux = {
				default_im = "keyboard-us",
				get_im_command = { "fcitx5-remote", "-n" },
				set_im_command = { "fcitx5-remote", "-s" },
			},
		},
	},
}
