local platform = require("kernel.platform")

if not platform.is_profile(platform.PROFILE.VSCODE) then
	require("config.autocmd.lsp_progress")
end
