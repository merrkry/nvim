local plugin_root = vim.fs.dirname(vim.fs.dirname(vim.fs.abspath(assert(debug.getinfo(1, "S")).source:sub(2))))
local child = vim.fn.jobstart({ vim.v.progpath, "--embed", "--headless", "-u", "NONE" }, { rpc = true })
local function lua(code, ...)
	return vim.rpcrequest(child, "nvim_exec_lua", code, { ... })
end

local ok, err = pcall(function()
	vim.rpcrequest(child, "nvim_ui_attach", 160, 24, {})
	lua(
		[[
		vim.opt.rtp:prepend(...)
		vim.o.laststatus = 0
		vim.o.ruler = false
		vim.o.showmode = false
		vim.wo.wrap = false
		vim.api.nvim_buf_set_lines(0, 0, -1, false, {string.rep("x", 130), ""})
		guides = require("wrap_guides")
		guides.setup()
	]],
		plugin_root
	)
	local function cell(row, col)
		return lua("vim.cmd('redraw!'); return vim.fn.screenstring(...)", row, col)
	end
	assert(cell(2, 101) == "▏", "guides are enabled by default at the default width")
	assert(cell(1, 101) == "x", "guide must not cover source text")
	lua("vim.api.nvim_buf_set_lines(0, 2, -1, false, {string.rep('x', 100)})")
	assert(cell(3, 100) == "x" and cell(3, 101) == "▏", "100 characters fit before the guide")
	lua("vim.api.nvim_buf_set_lines(0, 0, 1, false, {string.rep('x', 100)})")
	assert(cell(2, 101) == " ", "exactly the width does not activate the guide")
	lua("vim.api.nvim_buf_set_lines(0, 0, -1, false, {string.rep('x', 130), ''})")
	lua([[
		vim.bo.filetype = 'python'
		test_widths = 88
		guides.setup({ widths = function(buf)
			return vim.bo[buf].filetype == 'python' and test_widths or 100
		end })
	]])
	assert(cell(2, 89) == "▏" and cell(2, 101) == " ", "filetype width")
	lua("test_widths = {80, 100}")
	assert(cell(2, 81) == "▏" and cell(2, 101) == "▏", "simultaneous widths")
	lua("vim.api.nvim_buf_set_lines(0, 0, 1, false, {string.rep('x', 90)})")
	assert(cell(2, 81) == "▏" and cell(2, 101) == " ", "each threshold is independent")
	lua("vim.wo.wrap = true")
	assert(cell(2, 81) == " ", "wrap hides guides")
	lua("vim.wo.wrap = false; guides.disable()")
	assert(lua("return vim.fn.screenstring(2, 81)") == " ", "disable redraws immediately")
	lua("vim.wo.wrap = true; vim.wo.wrap = false")
	assert(cell(2, 81) == " ", "wrap toggle preserves manual disable")
	lua("guides.enable()")
	assert(cell(2, 81) == "▏", "enable restores guides")
	lua("guides.disable(); guides.enable(0)")
	assert(cell(2, 81) == "▏", "buffer enable overrides global disable")
	local original = lua("return vim.api.nvim_get_current_buf()")
	lua([[
		vim.cmd('new')
		vim.wo.wrap = false
		vim.api.nvim_buf_set_lines(0, 0, -1, false, {string.rep('x', 130), ''})
	]])
	assert(cell(2, 101) == " ", "new buffer inherits global disable")
	lua("guides.enable()")
	assert(cell(2, 101) == "▏", "inheriting buffer follows global enable")
	lua("guides.disable(0); guides.disable(); guides.enable()")
	assert(cell(2, 101) == " ", "global changes preserve buffer disable")
	lua("guides.disable(...)", original)
	lua("vim.cmd('close')")
	assert(cell(2, 81) == " ", "explicit buffer ID updates another buffer")
	lua("guides.reset(0)")
	assert(cell(2, 81) == "▏", "reset inherits global enable")
	lua("guides.enable(0); guides.disable(); guides.reset(0)")
	assert(cell(2, 81) == " ", "reset inherits global disable")
	lua("guides.enable()")
	lua("vim.cmd('split'); vim.wo.wrap = true")
	assert(cell(2, 81) == " ", "wrapped split is hidden")
	local row = lua("vim.cmd('wincmd j'); return vim.fn.win_screenpos(0)[1] + 1")
	assert(cell(row, 81) == "▏", "same buffer in unwrapped split remains visible")
	lua("vim.cmd('normal! 10zl')")
	assert(cell(row, 71) == "▏", "horizontal scrolling keeps buffer column")
	lua([[
		vim.cmd('only')
		vim.cmd('normal! 100zh')
		test_widths = {8, 10}
		vim.bo.tabstop = 8
		vim.api.nvim_buf_set_lines(0, 0, -1, false, { '\t中文', '' })
	]])
	assert(cell(2, 9) == "▏" and cell(2, 11) == "▏", "tabs and wide characters use display columns")
	lua("vim.bo.tabstop = 2")
	assert(cell(2, 9) == " " and cell(2, 11) == " ", "tabstop change invalidates cached widths")
	lua([[
		test_widths = { 4, 8 }
	]])
	assert(cell(2, 5) == "▏" and cell(2, 9) == " ", "filetype supports multiple widths")
	lua("vim.b.editorconfig = { max_line_length = '5' }")
	assert(cell(2, 6) == "▏" and cell(2, 5) == " ", "EditorConfig width overrides filetype")
end)
vim.fn.jobstop(child)
assert(ok, err)
print("wrap guide rendering checks passed")
