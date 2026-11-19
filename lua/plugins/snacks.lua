local file_filters = require("utils.file_filters")

---@type snacks.Config
local opts = {}

if not vim.g.vscode then
	---@module 'snacks'
	---@type snacks.Config
	local extra_opts = {
		bigfile = {
			size = 4 * 1024 * 1024,
		},
		indent = {
			animate = {
				enabled = false,
			},
		},
		input = {},
		notifier = {},
		picker = {
			limit_live = 1024,
			sources = {
				files = file_filters.file_picker_options(),
				grep = file_filters.grep_options(),
			},
			ui_select = true,
			win = {
				input = {
					keys = {
						["<A-h>"] = false,
						["<A-i>"] = { "toggle_ignored", mode = { "n", "i" } },
						["<Esc>"] = { "close", mode = { "n", "i" } },
					},
				},
				list = {
					keys = {
						["<A-h>"] = false,
						["<A-i>"] = "toggle_ignored",
					},
				},
			},
		},
		quickfile = {
			exclude = require("lang").treesitter_excludes(),
		},
		rename = {},
		statuscolumn = {},
		terminal = {},
	}
	opts = vim.tbl_deep_extend("error", opts, extra_opts)
end

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesActionRename",
	callback = function(event)
		Snacks.rename.on_rename_file(event.data.from, event.data.to)
	end,
})

---@type LazySpec
return {
	{
		"folke/snacks.nvim",
		priority = 900,
		lazy = false,
		-- It seems snacks has complicated initialization, simply call `require("snacks").setup(opts)` won't work
		opts = opts,
		keys = {
			{
				"<leader>n",
				function()
					Snacks.notifier.show_history()
				end,
				desc = "Show notification history",
			},
			{
				"<leader>j",
				function()
					Snacks.picker.jumps()
				end,
				desc = "Open jumplist picker",
			},
			{
				"<leader>'",
				function()
					Snacks.picker.resume()
				end,
				desc = "Resume last picker",
			},
			{
				"<leader>/",
				function()
					Snacks.picker.grep()
				end,
				desc = "Global search in workspace folder",
			},
			{
				"<leader>?",
				function()
					Snacks.picker.command_history()
				end,
				desc = "Open command history picker",
			},
			{
				"<leader>b",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Open buffer picker",
			},
			{
				"<leader>m",
				function()
					Snacks.picker.marks()
				end,
				desc = "Open mark picker",
			},
		},
	},
}
