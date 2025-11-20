return {
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		config = function()
			vim.diagnostic.config({
				severity_sort = true,
				float = { border = vim.o.winborder, source = true },
				underline = true,
				signs = vim.g.have_nerd_font
						and {
							-- read by tiny-inline-diagnostic.nvim
							text = {
								[vim.diagnostic.severity.ERROR] = "󰅚 ",
								[vim.diagnostic.severity.WARN] = "󰀪 ",
								[vim.diagnostic.severity.INFO] = "󰋽 ",
								[vim.diagnostic.severity.HINT] = "󰌶 ",
							},
							-- severity = {}, -- don't display anything on statuscolumn
						}
					or {},
				virtual_text = false,
				-- virtual_text = {
				-- 	current_line = nil, -- show both current and other lines
				-- 	spacing = 4,
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
				update_in_insert = false,
			})

			-- https://github.com/zed-industries/zed/blob/main/assets/themes/one/one.json
			vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#d07277" })
			vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#dec184" })
			vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#74ade8" })
			vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#788ca6" })

			require("tiny-inline-diagnostic").setup({
				preset = "simple",
				-- transparent_bg = true,
				hi = {
					-- All above hg will still be blended in some mysterious way.
					-- mixing_color = "#3b414d",
					mixing_color = "#282C33", -- zed's One Dark background
					-- background = "#FFFFFF",
				},
				blend = {
					factor = 26 / 255, -- zed uses alpha 1A for background
				},
				options = {
					use_icons_from_diagnostic = true,
					throttle = 250,
					multilines = {
						enabled = true,
						always_show = true, -- otherwise only show when current line has no diagnostics
						trim_whitespaces = true,
						severity = {
							vim.diagnostic.severity.ERROR,
						},
					},
					show_all_diags_on_cursorline = false,
					enable_on_insert = false,
					enable_on_select = false,
					overflow = {
						mode = "oneline",
						-- padding = 4,
					},
					format = function(diagnostic)
						local msg = diagnostic.message
						local function apply_patterns(patterns)
							for _, pattern in ipairs(patterns) do
								msg = string.gsub(msg, pattern, "")
							end
						end

						if diagnostic.source == "clippy" then
							apply_patterns({
								"%s*for further information visit https://[^%s]+",
								"%s*`[^`]*` implied by `[^`]*`%s*to override `[^`]*`%s*add `[^`]*`",
								"%s*`[^`]*` implied by `[^`]*`",
								"`#%[warn%b()%]`%s*%b()%s*on by default",
								"`#%[warn%b()%]`%s*on by default",
							})
						elseif diagnostic.source == "rustc" then
							apply_patterns({
								"`#%[warn%b()%]`%s*%b()%s*on by default",
								"`#%[warn%b()%]`%s*on by default",
							})
						end

						return msg -- .. " [" .. diagnostic.source .. "]"
					end,
				},
			})
		end,
		keys = {
			{
				"<leader>td",
				function()
					local diag = require("tiny-inline-diagnostic.diagnostic")
					diag.toggle()
					local state = require("tiny-inline-diagnostic.state")
					if state.user_toggle_state then
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
