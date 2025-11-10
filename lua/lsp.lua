local servers = {
	"basedpyright",
	"bashls",
	"clangd",
	"emmylua_ls", -- .emmyrc.json from https://www.reddit.com/r/neovim/comments/1mdtr4g/emmylua_ls_is_supersnappy/
	"gopls",
	"mesonlsp",
	"nixd",
	"prettier",
	"ruff",
	-- "rust_analyzer", -- handled by rustacea.nvim
	"taplo",
	"tinymist",
	"vtsls",
}

vim.lsp.log.set_level("OFF")

vim.lsp.enable(servers, true)
