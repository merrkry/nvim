local default_input_method = "keyboard-us"
vim.g.input_method = default_input_method

local function on_insert_leave()
	local current_mode = vim.api.nvim_get_mode().mode
	if current_mode == "c" or current_mode == "t" then
		return
	end

	local get_input_method = "fcitx5-remote -n"
	local input_method_str = vim.fn.system(get_input_method)
	vim.g.input_method = string.gsub(input_method_str, "[%c%s]+$", "")

	vim.fn.system(string.format("fcitx5-remote -s '%s'", default_input_method))
end

local function on_insert_enter()
	local current_mode = vim.api.nvim_get_mode().mode
	if current_mode == "c" or current_mode == "t" then
		return
	end

	local set_input_method = string.format("fcitx5-remote -s '%s'", vim.g.input_method)
	vim.fn.system(set_input_method)
end

local group_name = "fcitx5Switch"
vim.api.nvim_create_augroup(group_name, { clear = true })

vim.api.nvim_create_autocmd("InsertLeave", {
	group = group_name,
	callback = on_insert_leave,
	desc = "Inactivate fcitx5 on leaving insert mode",
})

vim.api.nvim_create_autocmd("InsertEnter", {
	group = group_name,
	callback = on_insert_enter,
	desc = "Resume fcitx5 on entering insert mode",
})
