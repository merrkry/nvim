local platform = require("kernel.platform")

---@param path string?
---@return string?
local function normalize_path(path)
	if not path or path == "" then
		return nil
	end

	local normalized = vim.fs.normalize(path)
	if platform.is_system(platform.SYSTEM.WINDOWS) then
		return normalized:lower()
	end

	return normalized
end

---@type LazySpec
return {
	{
		"mrjones2014/codesettings.nvim",
		ft = { "json", "jsonc", "lua" },
		opts = {
			lua_ls_integration = function()
				return normalize_path(vim.uv.cwd()) == normalize_path(vim.fn.stdpath("config"))
			end,
		},
	},
}
