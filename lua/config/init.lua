local M = {}

---@return nil
function M.pre_lazy()
	vim.g.mapleader = " "
	vim.g.maplocalleader = "\\"

	-- Neovim selects and caches a clipboard backend on the first clipboard access.
	-- Load this before plugins or options can trigger that access, so g:clipboard takes effect.
	require("config.clipboard")
	require("config.options")
end

---@return nil
function M.post_lazy()
	require("config.commands")
	require("config.keymaps")
end

return M
