---@type LazySpec
return {
	{
		"okuuva/auto-save.nvim",
		cmd = "ASToggle",
		event = { "InsertLeave", "TextChanged" },
		config = function()
			require("auto-save").setup({
				trigger_events = {
					defer_save = { "InsertLeave" },
					cancel_deferred_save = { "InsertEnter" },
				},
				condition = function(bufnr)
					local options = vim.bo[bufnr]
					return options.buftype == ""
						and options.filetype ~= "gitcommit"
						and vim.api.nvim_buf_get_name(bufnr) ~= ""
				end,
				noautocmd = true, -- avoid conflict with format on save
				debounce_delay = 4000,
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
			{ "\\S", "<cmd>ASToggle<CR>", desc = "Toggle auto save" },
		},
	},
}
