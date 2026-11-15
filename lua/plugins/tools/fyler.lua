---@type LazySpec
return {
	{
		"FylerOrg/fyler.nvim",
		init = function()
			vim.api.nvim_create_autocmd("SessionLoadPost", {
				group = vim.api.nvim_create_augroup("fyler_session_cleanup", { clear = true }),
				callback = function()
					-- :restart saves its session before VimLeavePre; restored trees have no instance.
					for _, buf in ipairs(vim.api.nvim_list_bufs()) do
						if vim.api.nvim_buf_get_name(buf):match("^fyler%-[^:]+://") then
							for _, win in ipairs(vim.fn.win_findbuf(buf)) do
								local can_close = vim.api.nvim_win_call(win, function()
									return vim.fn.winnr("$") > 1 or #vim.api.nvim_list_tabpages() > 1
								end)
								if can_close then
									vim.api.nvim_win_close(win, true)
								end
							end
							if vim.api.nvim_buf_is_valid(buf) then
								vim.api.nvim_buf_delete(buf, { force = true })
							end
						end
					end
				end,
			})

			vim.api.nvim_create_autocmd("VimLeavePre", {
				group = vim.api.nvim_create_augroup("fyler_close_on_exit", { clear = true }),
				callback = function()
					local finder = package.loaded["fyler.finder"]
					if not finder then
						return
					end

					-- Close explorer splits before auto-session saves the window layout.
					for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
						local instance = finder.instance_get_or_nil(tab)
						if instance then
							-- Fyler force-closes without writing pending file operations.
							instance:close()
						end
					end
				end,
			})

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("fyler_no_gutter", { clear = true }),
				pattern = "fyler_finder",
				callback = function(event)
					-- Fyler forces signcolumn=yes after FileType and after applying win_opts.
					-- Run later and clear Snacks' statuscolumn so Neovim releases its width.
					vim.schedule(function()
						for _, win in ipairs(vim.fn.win_findbuf(event.buf)) do
							vim.wo[win].signcolumn = "no"
							vim.wo[win].statuscolumn = " "
						end
					end)
				end,
			})
		end,
		opts = {
			auto_confirm_simple_mutation = true,
			extensions = {
				git = { enabled = false },
				trash = { enabled = true },
				watcher = { enabled = true },
			},
			integrations = {
				icon = "mini_icons",
			},
			mappings = {
				n = {
					["<A-i>"] = {
						action = "toggle_ui",
						args = { "hidden_items" },
						desc = "Toggle hidden files",
					},
				},
			},
			ui = {
				indent_guides = true,
			},
		},
		keys = {
			{
				"<leader>e",
				function()
					-- Reuse a visible explorer even if Fyler lost track of its window.
					for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
						local buf = vim.api.nvim_win_get_buf(win)
						if vim.bo[buf].filetype == "fyler_finder" then
							vim.api.nvim_set_current_win(win)
							return
						end
					end

					require("fyler").open({ kind = "split_right_most" })
				end,
				desc = "Open file explorer",
			},
		},
	},
}
