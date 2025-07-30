return {
	{
		"echasnovski/mini.nvim",
		version = false, -- change to '*' to use release branches
		config = function()
			require("mini.icons").setup()
			require("mini.icons").mock_nvim_web_devicons()

			require("mini.surround").setup({
				-- from LazyVim
				mappings = {
					add = "<leader>sa", -- Add surrounding in Normal and Visual modes
					delete = "<leader>sd", -- Delete surrounding
					find = "<leader>sf", -- Find surrounding (to the right)
					find_left = "<leader>sF", -- Find surrounding (to the left)
					highlight = "<leader>sh", -- Highlight surrounding
					replace = "<leader>sr", -- Replace surrounding
					update_n_lines = "<leader>sn", -- Update `n_lines`
				},
			})

			require("mini.cursorword").setup()
		end,
		keys = {},
	},
}
