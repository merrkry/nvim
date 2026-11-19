---@type LazySpec
return {
	{
		"mrjones2014/codesettings.nvim",
		ft = { "json", "jsonc", "lua" },
		opts = {
			lua_ls_integration = function()
				local cwd = vim.uv.fs_stat(".")
				local config = vim.uv.fs_stat(vim.fn.stdpath("config"))
				return cwd ~= nil and config ~= nil and cwd.dev == config.dev and cwd.ino == config.ino
			end,
		},
	},
}
