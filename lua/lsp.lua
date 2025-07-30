local servers = {
	"basedpyright",
	"bashls",
	"clangd",
	"gopls",
	"lua_ls",
	"nil_ls",
	"nixd",
	"prettier",
	"ruff",
	"rust_analyzer",
	"taplo",
}

vim.lsp.enable(servers, true)
