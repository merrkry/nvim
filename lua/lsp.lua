local servers = {
	"basedpyright",
	"bashls",
	"clangd",
	"emmylua_ls", -- .emmyrc.json from https://www.reddit.com/r/neovim/comments/1mdtr4g/emmylua_ls_is_supersnappy/
	"gopls",
	"nil_ls",
	"nixd",
	"prettier",
	"ruff",
	"rust_analyzer",
	"taplo",
}

vim.lsp.enable(servers, true)
