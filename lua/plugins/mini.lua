return {
	{
		'echasnovski/mini.nvim',
		version = false, -- change to '*' to use release branches
		config = function()
			require('mini.icons').setup()
			require("mini.icons").mock_nvim_web_devicons()

			require('mini.surround').setup(
				{
					-- from LazyVim
					mappings = {
						add = "gsa", -- Add surrounding in Normal and Visual modes
						delete = "gsd", -- Delete surrounding
						find = "gsf", -- Find surrounding (to the right)
						find_left = "gsF", -- Find surrounding (to the left)
						highlight = "gsh", -- Highlight surrounding
						replace = "gsr", -- Replace surrounding
						update_n_lines = "gsn", -- Update `n_lines`
					},
				}
			)
		end,
	},
}
