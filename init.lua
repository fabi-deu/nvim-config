-- set globals
vim.g.have_nerd_font = true
vim.g.transparent_bg = true


require("config.lazy")
require("config.lsp")

vim.cmd.colorscheme("oxocarbon")

return {}
