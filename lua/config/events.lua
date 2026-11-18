return {
	-- LazyVim's LazyFile triggers.
	-- https://github.com/LazyVim/LazyVim/discussions/1583
	lazy_file = { { event = { "BufReadPost", "BufNewFile", "BufWritePre" } } },
}
