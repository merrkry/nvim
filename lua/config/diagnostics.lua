vim.diagnostic.config({
	severity_sort = true,
	float = { border = vim.o.winborder, source = true },
	underline = { severity = { min = vim.diagnostic.severity.ERROR } },
	signs = {
		-- Read by tiny-inline-diagnostic.nvim and statuscolumn.
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚",
			[vim.diagnostic.severity.WARN] = "󰀪",
			[vim.diagnostic.severity.INFO] = "󰋽",
			[vim.diagnostic.severity.HINT] = "󰌶",
		},
	},
	-- signs = false, -- don't display anything on statuscolumn
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

vim.keymap.set("n", "<leader>k", function()
	if #vim.lsp.get_clients({ bufnr = 0, name = "rust-analyzer" }) > 0 then
		vim.cmd.RustLsp({ "renderDiagnostic", "current" })
	else
		vim.diagnostic.open_float()
	end
end, { desc = "Show diagnostics" })

vim.keymap.set("n", "<leader>d", function()
	Snacks.picker("diagnostics_buffer")
end, { desc = "Open diagnostics picker" })

vim.keymap.set("n", "<leader>D", function()
	Snacks.picker("diagnostics")
end, { desc = "Open workspace diagnostics picker" })
