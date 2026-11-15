local M = {}

local in_vscode = vim.g.vscode
local installed_parsers = {}
local installed_queries = {}

---@param values string[]
---@return table<string, boolean>
local function to_set(values)
	local set = {}
	for _, value in ipairs(values) do
		set[value] = true
	end
	return set
end

---@return nil
local function refresh_installed()
	local treesitter = require("nvim-treesitter")
	installed_parsers = to_set(treesitter.get_installed("parsers"))
	installed_queries = to_set(treesitter.get_installed("queries"))
end

---@param bufnr integer
---@param language string
---@return nil
local function attach_treesitter(bufnr, language)
	if in_vscode then
		-- vscode-neovim owns highlighting, indentation, and folding. Keep a parser
		-- available for editing plugins such as mini.ai and nvim-tree-pairs.
		vim.treesitter.get_parser(bufnr, language)
		return
	end

	vim.wo.foldmethod = "expr"
	vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

	vim.treesitter.start(bufnr, language)

	vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

---@param parsers string[]
---@return nil
function M.install_parsers(parsers)
	require("nvim-treesitter").install(parsers):await(function(error)
		if not error then
			refresh_installed()
		end
	end)
end

---@return nil
function M.setup()
	local treesitter = require("nvim-treesitter")
	local available = to_set(treesitter.get_available())
	local excluded = to_set(require("lang").treesitter_excludes())
	local attempted_install = {}
	-- install() reloads parser metadata even when both artifacts already exist.
	-- Cache nvim-treesitter's install directories and attach directly on the common path.
	refresh_installed()

	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup("TreesitterSetup", {}),
		callback = function(args)
			local bufnr = args.buf
			local filetype = args.match
			local language = vim.treesitter.language.get_lang(filetype) or filetype

			if not available[language] or excluded[language] then
				return
			end

			local function attach()
				if not vim.api.nvim_buf_is_valid(bufnr) then
					return
				end

				if not vim.treesitter.language.add(language) then
					return
				end

				attach_treesitter(bufnr, language)
			end

			if installed_parsers[language] and installed_queries[language] then
				attach()
				return
			end

			if attempted_install[language] then
				return
			end
			attempted_install[language] = true

			treesitter.install(language, { force = true }):await(function(error, success)
				if error or not success then
					return
				end

				installed_parsers[language] = true
				installed_queries[language] = true
				attach()
			end)
		end,
	})
end

return M
