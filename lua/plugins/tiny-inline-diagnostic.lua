return {
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		config = function()
			vim.diagnostic.config({
				severity_sort = true,
				float = { border = vim.o.winborder, source = "if_many" },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = vim.g.have_nerd_font and {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				} or {},
				virtual_text = false,
				-- {
				-- 	source = "if_many",
				-- 	spacing = 2,
				-- 	format = function(diagnostic)
				-- 		local diagnostic_message = {
				-- 			[vim.diagnostic.severity.ERROR] = diagnostic.message,
				-- 			[vim.diagnostic.severity.WARN] = diagnostic.message,
				-- 			[vim.diagnostic.severity.INFO] = diagnostic.message,
				-- 			[vim.diagnostic.severity.HINT] = diagnostic.message,
				-- 		}
				-- 		return diagnostic_message[diagnostic.severity]
				-- 	end,
				-- },
			})

			require("tiny-inline-diagnostic").setup({
				preset = "simple",
				options = {
					use_icons_from_diagnostic = true,
					throttle = 100,
					multilines = {
						enabled = false,
						always_show = true, -- otherwise only show when current line has no diagnostics
						trim_whitespaces = true,
					},
					show_all_diags_on_cursorline = false,
				},
			})
		end,
		keys = {
			{
				"<leader>td",
				function()
					local diag = require("tiny-inline-diagnostic.diagnostic")
					diag.toggle()
					if diag.user_toggle_state then
						vim.notify("diagnostics enabled")
					else
						vim.notify("diagnostics disabled")
					end
				end,
				desc = "Toggle diagnostics",
			},
		},
	},
}
