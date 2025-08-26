return {
	{
		"okuuva/auto-save.nvim",
		cmd = "ASToggle",
		event = { "InsertLeave", "TextChanged" },
		config = function()
			local excluded_filetypes = {
				"gitcommit",
				"harpoon",
				"oil",
			}

			require("auto-save").setup({
				condition = function(bufnr)
					if vim.tbl_contains(excluded_filetypes, vim.fn.getbufvar(bufnr, "&filetype")) then
						return false
					end
					return true
				end,
				noautocmd = true, -- avoid conflict with format on save
			})

			local group = vim.api.nvim_create_augroup("autosave", {})

			vim.api.nvim_create_autocmd("User", {
				pattern = "AutoSaveEnable",
				group = group,
				callback = function(_opts)
					vim.notify("Auto save enabled", vim.log.levels.INFO)
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "AutoSaveDisable",
				group = group,
				callback = function(_opts)
					vim.notify("Auto save disabled", vim.log.levels.INFO)
				end,
			})
		end,
		keys = {
			{ "<leader>ts", "<cmd>ASToggle<CR>", desc = "Toggle auto save" },
		},
	},
}
