local M = {}

local excluded_names = {
	".direnv",
	".git",
	".gradle",
	".next",
	".nuxt",
	".svelte-kit",
	".venv",
	".zig-cache",
	"__pycache__",
	"node_modules",
	"result",
	"target",
	"venv",
	"zig-out",
}

local excluded_patterns = {
	"cmake-build-*",
	"result-*",
}

local lockfile_patterns = {
	"*.lock",
	"*-lock.json",
	"*-lock.yaml",
	"*.lock.json",
	"bun.lockb",
	"go.sum",
	"npm-shrinkwrap.json",
}

---@param globs string[]
---@return fun(item: { file?: string }): boolean
local function exclude_globs_filter(globs)
	local matchers = {}
	for _, glob in ipairs(globs) do
		matchers[#matchers + 1] = vim.glob.to_lpeg(glob)
	end

	return function(item)
		if not item.file then
			return true
		end

		for component in item.file:gmatch("[^/\\]+") do
			for _, matcher in ipairs(matchers) do
				if matcher:match(component) then
					return false
				end
			end
		end

		return true
	end
end

---@return string[]
local function search_excluded_globs()
	local globs = vim.list_extend({}, excluded_names)
	vim.list_extend(globs, excluded_patterns)
	return vim.list_extend(globs, lockfile_patterns)
end

---@return { exclude: string[], filter: { filter: fun(item: { file?: string }): boolean }, hidden: boolean, ignored: boolean }
function M.file_picker_options()
	local exclude = search_excluded_globs()
	return {
		exclude = exclude,
		filter = { filter = exclude_globs_filter(exclude) },
		hidden = true,
		ignored = false,
	}
end

---@return { exclude: string[], hidden: boolean, ignored: boolean }
function M.grep_options()
	return {
		exclude = search_excluded_globs(),
		hidden = true,
		ignored = false,
	}
end

return M
