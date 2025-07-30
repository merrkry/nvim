return {
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		dependencies = { { "echasnovski/mini.nvim", opts = {} } },
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
		keys = {
			{ "<leader>e", "<cmd>Oil<cr>", desc = "Open buffer file explorer" },
		},
		config = function()
			require("oil").setup({
				delete_to_trash = true,
				watch_for_changes = true,

				keymaps = {
					["<C-h>"] = false,
					["<C-l"] = false,
					-- <C-p> to preview with automatically selected position
					["<A-h>"] = { "actions.select", opts = { horizontal = true } },
					["<A-v>"] = { { "actions.select", opts = { vertical = true } } },
				},
				view_options = {
					show_hidden = true,
				},
			})

			-- https://github.com/folke/snacks.nvim/blob/main/docs/rename.md#oilnvim
			vim.api.nvim_create_autocmd("User", {
				pattern = "OilActionsPost",
				callback = function(event)
					if event.data.actions.type == "move" then
						require("snacks").rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
					end
				end,
			})
		end,
	},
}
