local M = {}

local in_vscode = vim.g.vscode
local indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
local installed = {}
---@type table<string, table<integer, boolean>?>
local installing = {}

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
	local queries = to_set(treesitter.get_installed("queries"))
	installed = {}
	for _, language in ipairs(treesitter.get_installed("parsers")) do
		installed[language] = queries[language]
	end
end

---@param bufnr integer
local function setup_folding(bufnr)
	for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
		local options = vim.wo[win][0]
		options.foldmethod = "expr"
		options.foldexpr = "v:lua.vim.treesitter.foldexpr()"
	end
end

---@param bufnr integer
---@param language string
---@return nil
local function attach_treesitter(bufnr, language)
	if
		not vim.api.nvim_buf_is_loaded(bufnr)
		or vim.treesitter.language.get_lang(vim.bo[bufnr].filetype) ~= language
	then
		return
	end
	if not vim.treesitter.language.add(language) then
		return
	end

	if in_vscode then
		-- vscode-neovim owns highlighting, indentation, and folding. Keep a parser
		-- available for editing plugins such as mini.ai and nvim-tree-pairs.
		vim.treesitter.get_parser(bufnr, language)
		return
	end

	vim.treesitter.start(bufnr, language)
	vim.bo[bufnr].indentexpr = indentexpr
	setup_folding(bufnr)
end

---@param parsers string[]
---@param bufnr? integer
---@return nil
function M.install_parsers(parsers, bufnr)
	local missing = {}
	for _, language in ipairs(parsers) do
		if not installed[language] then
			local buffers = installing[language]
			if not buffers then
				buffers = {}
				installing[language] = buffers
				missing[#missing + 1] = language
			end
			if bufnr then
				buffers[bufnr] = true
			end
		end
	end
	if #missing == 0 then
		return
	end

	-- The installer considers a language installed when either artifact exists.
	require("nvim-treesitter").install(missing, { force = true }):await(function(error)
		if not error then
			refresh_installed()
		end
		for _, language in ipairs(missing) do
			local buffers = installing[language]
			installing[language] = nil
			if buffers and installed[language] then
				for pending_buf in pairs(buffers) do
					attach_treesitter(pending_buf, language)
				end
			end
		end
	end)
end

---@return nil
function M.setup()
	local treesitter = require("nvim-treesitter")
	local available = to_set(treesitter.get_available())
	local excluded = to_set(require("lang").treesitter_excludes())
	-- install() reloads parser metadata even when both artifacts already exist.
	-- Cache nvim-treesitter's install directories and attach directly on the common path.
	refresh_installed()

	local group = vim.api.nvim_create_augroup("TreesitterSetup", {})
	if in_vscode then
		vim.api.nvim_create_autocmd("FileType", {
			group = group,
			callback = function(args)
				-- Some built-in ftplugins start highlighting themselves.
				vim.schedule(function()
					if vim.api.nvim_buf_is_valid(args.buf) then
						vim.treesitter.stop(args.buf)
					end
				end)
			end,
		})
	else
		vim.api.nvim_create_autocmd("BufWinEnter", {
			group = group,
			callback = function(args)
				if vim.bo[args.buf].indentexpr == indentexpr then
					setup_folding(args.buf)
				end
			end,
		})
	end

	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		callback = function(args)
			local bufnr = args.buf
			local language = vim.treesitter.language.get_lang(args.match)

			if not language or not available[language] or excluded[language] then
				return
			end

			if installed[language] then
				attach_treesitter(bufnr, language)
				return
			end

			M.install_parsers({ language }, bufnr)
		end,
	})
end

return M
