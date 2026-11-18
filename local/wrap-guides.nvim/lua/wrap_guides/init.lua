local M = {}
local ns = vim.api.nvim_create_namespace("wrap_guides")
local globally_enabled = true

---@type fun(buf: integer): integer|integer[]
local widths = function()
	return 100
end

---@type table<integer, {tick: integer, tabs: string, width: integer}>
local lengths = {}
---@type table<integer, {left: integer, visible: integer[]}>
local columns = {}

local function redraw()
	vim.cmd("redraw!")
end

---@param value boolean
---@param buf? integer
local function set_enabled(value, buf)
	if buf == nil then
		globally_enabled = value
	else
		vim.b[buf].wrap_guides_enabled = value
	end
	redraw()
end

--- Set the global default, or override a buffer (0 selects the current buffer).
---@param buf? integer
function M.enable(buf)
	set_enabled(true, buf)
end

---@param buf? integer
function M.disable(buf)
	set_enabled(false, buf)
end

--- Restore a buffer's inheritance of the global default.
---@param buf? integer
function M.reset(buf)
	vim.b[buf or 0].wrap_guides_enabled = nil
	redraw()
end

--- Resolve the buffer setting. Window wrap and width thresholds still affect visibility.
---@param buf? integer
---@return boolean
function M.is_enabled(buf)
	local override = vim.b[buf or 0].wrap_guides_enabled
	if override ~= nil then
		return override
	end
	return globally_enabled
end

---@param buf integer
---@return integer[]
local function widths_for(buf)
	local configured = widths(buf)
	local editorconfig = vim.b[buf].editorconfig
	local max_length = editorconfig and tonumber(editorconfig.max_line_length)
	if max_length then
		return {
			max_length --[[@as integer]],
		}
	end
	return type(configured) == "table" and configured or { configured }
end

---@param buf integer
---@return integer
local function longest_line(buf)
	local tick = vim.api.nvim_buf_get_changedtick(buf)
	local tabs = vim.bo[buf].tabstop .. ":" .. vim.bo[buf].vartabstop .. ":" .. vim.o.ambiwidth
	local cached = lengths[buf]
	if cached and cached.tick == tick and cached.tabs == tabs then
		return cached.width
	end
	local width = 0
	for _, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
		width = math.max(width, vim.fn.strdisplaywidth(line))
	end
	lengths[buf] = { tick = tick, tabs = tabs, width = width }
	return width
end

---@param opts? { widths?: fun(buf: integer): integer|integer[] }
function M.setup(opts)
	widths = opts and opts.widths or function()
		return 100
	end
	local group = vim.api.nvim_create_augroup("WrapGuides", { clear = true })
	local function highlight()
		vim.api.nvim_set_hl(0, "WrapGuide", { link = "NonText", default = true })
	end
	highlight()
	vim.api.nvim_create_autocmd("ColorScheme", { group = group, callback = highlight })
	-- An edit can cross a threshold and change guides on otherwise untouched lines.
	vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "TextChangedP", "FileType" }, {
		group = group,
		callback = redraw,
	})
	vim.api.nvim_create_autocmd("OptionSet", {
		group = group,
		pattern = { "wrap", "tabstop", "vartabstop", "ambiwidth" },
		callback = redraw,
	})
	vim.api.nvim_create_autocmd("BufWipeout", {
		group = group,
		callback = function(event)
			lengths[event.buf] = nil
		end,
	})
	vim.api.nvim_set_decoration_provider(ns, {
		on_start = function()
			columns = {}
		end,
		on_win = function(_, win, buf)
			if not M.is_enabled(buf) then
				return false
			end
			local ft = vim.bo[buf].filetype
			if vim.wo[win].wrap or vim.bo[buf].buftype ~= "" or ft == "help" or ft == "text" then
				return false
			end
			-- Display widths and horizontal scroll belong to this window, even in splits.
			columns[win] = vim.api.nvim_win_call(win, function()
				local max_width = longest_line(buf)
				local left = vim.fn.winsaveview().leftcol
				local visible = vim.api.nvim_win_get_width(win) - vim.fn.getwininfo(win)[1].textoff
				local result = {}
				for _, width in ipairs(widths_for(buf)) do
					-- The guide starts after `width` display cells, at the next cell's left edge.
					local col = width - left
					if max_width > width and col >= 0 and col < visible then
						result[#result + 1] = col
					end
				end
				return { left = left, visible = result }
			end)
			return #columns[win].visible > 0
		end,
		on_range = function(_, win, buf, start_row, _, end_row, end_col)
			local stop_row = end_col == 0 and end_row or end_row + 1
			local lines = vim.api.nvim_buf_get_lines(buf, start_row, stop_row, false)
			for index, line in ipairs(lines) do
				local row = start_row + index - 1
				local width = vim.fn.strdisplaywidth(line)
				for _, col in ipairs(columns[win].visible) do
					local target = col + columns[win].left + 1
					local byte = vim.fn.virtcol2col(win, row + 1, target)
					-- Draw through whitespace, but never cover source characters.
					if width < target or line:sub(byte, byte):match("%s") then
						vim.api.nvim_buf_set_extmark(buf, ns, row, 0, {
							virt_text = { { "▏", "WrapGuide" } },
							virt_text_win_col = col,
							virt_text_pos = "overlay",
							hl_mode = "combine",
							priority = 1,
							ephemeral = true,
						})
					end
				end
			end
		end,
	})
end

return M
