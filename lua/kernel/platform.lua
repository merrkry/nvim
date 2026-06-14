---@alias System integer
local SYSTEM = {
	LINUX = 0,
	DARWIN = 1,
	WINDOWS = 2,
}

---@alias Profile integer
local PROFILE = {
	IDE = 0,
	VSCODE = 1,
	EDITOR = 2,
	MINIMAL = 3,
	VANILLA = 4,
}

---@return System
local function detect_system()
	if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
		return SYSTEM.WINDOWS
	end

	if vim.fn.has("macunix") == 1 then
		return SYSTEM.DARWIN
	end

	return SYSTEM.LINUX
end

---@return Profile
local function detect_profile()
	if vim.g.vscode then
		return PROFILE.VSCODE
	end

	return PROFILE.IDE
end

---@type System
local current_system = detect_system()
---@type Profile
local current_profile = detect_profile()

local M = {
	SYSTEM = SYSTEM,
	PROFILE = PROFILE,
}

---@param system System
---@return boolean
function M.is_system(system)
	return current_system == system
end

---@param profile Profile
---@return boolean
function M.is_profile(profile)
	return current_profile == profile
end

---@return boolean
function M.lsp_enabled()
	return M.is_profile(PROFILE.IDE)
end

---@return boolean
function M.treesitter_enabled()
	return true
end

return M
