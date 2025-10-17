return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		keys = {
			{
				"<leader>tc",
				function()
					require("copilot.suggestion").toggle_auto_trigger()
					if vim.b.copilot_suggestion_hidden then
						vim.notify("Copilot auto trigger disabled")
					else
						vim.notify("Copilot auto trigger enabled")
					end
				end,
				desc = "Toggle Copilot auto trigger",
			},
		},
		config = function()
			require("copilot").setup({
				panel = {
					enabled = false,
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					debounce = 100,
					keymap = {
						accept = "<C-y>",
						accept_word = "<C-l>",
						accept_line = "<C-j>",
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-n>",
					},
				},
				filetypes = {
					c = true,
					cpp = true,
					go = true,
					lua = true,
					python = true,
					rust = true,
					["*"] = false,
				},
				server_opts_overrides = {
					settings = {
						telemetry = {
							telemetryLevel = "off",
						},
					},
				},
			})

			-- required by suggestion.hide_during_completion
			vim.api.nvim_create_autocmd("User", {
				pattern = "BlinkCmpMenuOpen",
				callback = function()
					require("copilot.suggestion").dismiss()
					vim.b.copilot_suggestion_hidden = true
				end,
			})
			vim.api.nvim_create_autocmd("User", {
				pattern = "BlinkCmpMenuClose",
				callback = function()
					vim.b.copilot_suggestion_hidden = false
				end,
			})

			-- Directly bind accept to <Tab> will cause issues, or won't work at all.
			-- https://github.com/zbirenbaum/copilot.lua/discussions/153#discussioncomment-5701223
			-- vim.keymap.set("i", "<Tab>", function()
			-- 	if require("copilot.suggestion").is_visible() then
			-- 		require("copilot.suggestion").accept()
			-- 	else
			-- 		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
			-- 	end
			-- end, { desc = "Super Tab" })
		end,
	},
}
