return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
		keys = {
			{
				"<leader>tp",
				function()
					local npairs = require("nvim-autopairs")

					npairs.toggle()

					local current_state_str
					if npairs.state.disabled then
						current_state_str = "disabled"
					else
						current_state_str = "enabled"
					end
					vim.notify("Auto pair " .. current_state_str)
				end,
				desc = "Toggle auto pair",
			},
		},
	},
}
