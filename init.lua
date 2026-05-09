-- set globals
vim.g.have_nerd_font = true
vim.g.transparent_bg = true


require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")
require("config.lsp")

vim.cmd.colorscheme("oxocarbon")

return {}
