-- Run each test in a fresh Neovim process without user configuration or external plugins.
local tests = vim.fn.glob("tests/*.lua", false, true)
vim.list_extend(tests, vim.fn.glob("local/*/tests/*.lua", false, true))
table.sort(tests)
for _, test in ipairs(tests) do
	if test ~= "tests/run.lua" then
		local result = vim.system({ vim.v.progpath, "--headless", "-u", "NONE", "-l", test }, { text = true }):wait()
		io.stdout:write(result.stdout or "")
		io.stderr:write(result.stderr or "")
		assert(result.code == 0, test .. " failed with exit code " .. result.code)
	end
end
