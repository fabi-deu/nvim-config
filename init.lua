-- set globals
vim.g.have_nerd_font = true
vim.g.transparent_bg = false


require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")
require("config.lsp")

vim.cmd.colorscheme("vague")

return {}
