---@type LazySpec
return {
	{
		"rmagatti/auto-session",
		lazy = false,
		init = function()
			-- Skip unnamed and special windows when writing sessions, including :restart.
			vim.o.sessionoptions = "curdir,folds,tabpages,winsize,winpos,localoptions"
		end,
		opts = function()
			return {
				-- Startup commands such as :DiffEditor own the initial layout.
				auto_restore = not vim.iter(vim.v.argv):any(function(arg)
					return arg == "-c" or vim.startswith(arg, "+")
				end),
				auto_create = function()
					if vim.fn.executable("git") == 0 then
						return false
					end
					local result = vim.system({ "git", "rev-parse", "--is-inside-work-tree" }, { text = true }):wait()
					return result.code == 0 and vim.trim(result.stdout) == "true"
				end,
				close_unsupported_windows = { preserve_buftypes = { "" } },
				purge_after_minutes = 20160, -- two weeks
				continue_restore_on_error = false,
				lazy_support = true,
				legacy_cmds = false,
			}
		end,
	},
}
