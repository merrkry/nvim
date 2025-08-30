return {
	{
		"nvim-mini/mini.nvim",
		version = false, -- change to '*' to use release branches
		config = function()
			require("mini.ai").setup()

			require("mini.move").setup()

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

			require("mini.bracketed").setup()

			require("mini.files").setup({
				options = {
					permanent_delete = false, -- mini doesn't provide xdg trash support, hopefully git saves us
					use_as_default_explorer = false,
				},
				windows = {
					preview = true,
					width_preview = 80,
				},
			})

			-- replaced by hop.nvim
			-- require("mini.jump").setup({
			-- 	delay = {
			-- 		highlight = 250,
			-- 		idle_stop = 2500,
			-- 	},
			-- })
			-- vim.api.nvim_set_hl(0, "MiniJump", { link = "Search" })

			require("mini.cursorword").setup()

			require("mini.icons").setup()
			require("mini.icons").mock_nvim_web_devicons()

			vim.api.nvim_create_autocmd("InsertEnter", {
				once = true,
				callback = function()
					-- Ensure this is lazily loaded to avoid conflict with Snacks.dashboard
					require("mini.trailspace").setup({
						only_in_normal_buffers = true,
					})
				end,
			})
		end,
		keys = {
			{
				"<leader>e",
				function()
					require("mini.files").open(vim.api.nvim_buf_get_name(0))
				end,
				desc = "Open floating file explorer",
			},
		},
	},
}
