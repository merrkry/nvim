return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = {},
			-- dashboard = {
			-- 	preset = {
			-- 		header = table.concat({
			-- 			[[                                                                       ]],
			-- 			[[                                                                     ]],
			-- 			[[       ████ ██████           █████      ██                     ]],
			-- 			[[      ███████████             █████                             ]],
			-- 			[[      █████████ ███████████████████ ███   ███████████   ]],
			-- 			[[     █████████  ███    █████████████ █████ ██████████████   ]],
			-- 			[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
			-- 			[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
			-- 			[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
			-- 			[[                                                                       ]],
			-- 		}, "\n"),
			-- 	},
			-- 	sections = {
			-- 		{ section = "header" },
			-- 		{
			-- 			-- pane = 2,
			-- 			icon = " ",
			-- 			title = "Git Status",
			-- 			section = "terminal",
			-- 			enabled = function()
			-- 				return Snacks.git.get_root() ~= nil
			-- 			end,
			-- 			cmd = "git status --short --branch --renames",
			-- 			ttl = 60,
			-- 		},
			-- 		{ section = "startup" },
			-- 	},
			-- },
			indent = {
				animate = {
					enabled = false,
				},
			},
			input = {},
			notifier = {},
			picker = {
				limit_live = 1000,
				ui_select = true,
			},
			quickfile = {},
		},
		keys = {
			{
				"<leader>n",
				function()
					require("snacks").notifier.show_history()
				end,
				desc = "Show notification history",
			},
			{
				"<leader> ",
				function()
					require("snacks").picker.pick("files", {
						matcher = {
							cwd_bonus = true,
							frequency = true,
							history_bonus = true,
						},
					})
				end,
				desc = "Open file picker",
			},
			{
				"<leader>f",
				function()
					require("snacks").picker.pick("lsp_symbols")
				end,
				desc = "Open document symbol picker",
			},
			{
				"<leader>b",
				function()
					require("snacks").picker.pick("buffers")
				end,
				desc = "Open buffer picker",
			},
			{
				"<leader>/",
				function()
					require("snacks").picker.pick("grep")
				end,
				desc = "Search with ripgrep",
			},
			{
				"<leader>?",
				function()
					require("snacks").picker.pick("keymaps")
				end,
				desc = "Search keymaps",
			},
		},
	},
}
