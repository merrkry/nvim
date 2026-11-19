vim.api.nvim_create_user_command("RestoreStyling", function()
	local hover_ns = vim.api.nvim_get_namespaces()["nvim.lsp.hover_range"] ---@as integer | nil
	if hover_ns then
		vim.api.nvim_buf_clear_namespace(0, hover_ns, 0, -1)
	end

	if vim.snippet.active() then
		vim.snippet.stop()
	end

	vim.lsp.buf.clear_references()
end, {})
