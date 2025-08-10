-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Disable some builin bindings to eliminate error
vim.keymap.del("n", "gri")
vim.keymap.del("n", "gra")
vim.keymap.del("n", "grn")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "grt")

-- Quick quit
vim.keymap.set("n", "<leader>w", "<cmd>wall<CR>", { desc = "Write all buffers" })
vim.keymap.set("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit buffer" })
vim.keymap.set("n", "<leader>Q", "<cmd>wqall<CR>", { desc = "Write and quit all buffers" })

-- Navigation under insert mode

vim.keymap.set("i", "<M-k>", "<up>")
vim.keymap.set("i", "<M-j>", "<down>")
vim.keymap.set("i", "<M-h>", "<left>")
vim.keymap.set("i", "<M-l>", "<right>")

vim.keymap.set("i", "<M-w>", "<C-o>w")
vim.keymap.set("i", "<M-W>", "<C-o>W")
vim.keymap.set("i", "<M-b>", "<C-o>b")
vim.keymap.set("i", "<M-B>", "<C-o>B")
vim.keymap.set("i", "<M-e>", "<C-o>e")
vim.keymap.set("i", "<M-E>", "<C-o>E")

vim.keymap.set("i", "<M-a>", "<C-o>0")
vim.keymap.set("i", "<M-e>", "<C-o>$")
vim.keymap.set("i", "<M-m>", "<C-o>_")

-- System clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste after curcor, from system clipboard" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste before curcor, from system clipboard" })
