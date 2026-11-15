local file_filters = require("utils.file_filters")

---@param cwd string
local function open(cwd)
	local opts = file_filters.file_picker_options()
	opts.cwd = cwd
	require("neural-open").open(opts)
end

---@type LazySpec
return {
	{
		"dtormoen/neural-open.nvim",
		dependencies = {
			"folke/snacks.nvim",
		},
		lazy = false, -- builtin
		opts = {
			file_sources = {
				"buffers",
				"files",
			},
		},
		keys = {
			{
				"<leader>f",
				function()
					local workspace = vim.lsp.buf.list_workspace_folders()
					local target
					if workspace and #workspace > 0 then
						target = workspace[1]
					else
						target = vim.uv.cwd()
					end
					open(target)
				end,
				desc = "Open file picker at LSP workspace root",
			},
			{
				"<leader>F",
				function()
					open(vim.uv.cwd())
				end,
				desc = "Open file picker at current working directory",
			},
		},
	},
}
