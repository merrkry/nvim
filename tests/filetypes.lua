vim.opt.rtp:prepend(".")
require("config.options")

local function filetype(filename)
	return vim.filetype.match({ filename = filename })
end

assert(filetype("C:\\project\\.github\\workflows\\check.yml") == "yaml.ghaction")
assert(filetype(".github/workflows/check.yaml") == "yaml.ghaction")
assert(filetype("project/xgithub/workflows/check.yaml") == "yaml")
assert(filetype(".github/workflows/check.yaml.txt") == "text")
assert(filetype("values.yaml.enc") == "yaml")
assert(filetype("values.yml.enc") == "yaml")
assert(filetype("valuesxymlyenc") ~= "yaml")
