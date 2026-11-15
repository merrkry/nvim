if vim.g.vscode then
	vim.g.clipboard = vim.g.vscode_clipboard
elseif vim.fn.has("win32") == 1 then
	-- The Windows build of Neovim ships with win32yank. Selecting it explicitly
	-- avoids probing slower fallbacks such as PowerShell on the first + operation.
	vim.g.clipboard = "win32yank"
end

-- Keep the unnamed register independent from the system clipboard.
vim.o.clipboard = ""

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste after cursor from system clipboard" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste before cursor from system clipboard" })
