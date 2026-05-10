return {
	{
		"nvim-mini/mini.nvim",
		config = function ()
			-- better surroundings and around/inside
			require("mini.ai").setup { n_lines = 500 }
			require("mini.surround").setup()

			-- statusline
			local sl = require("mini.statusline")
			sl.setup { use_icons = vim.g.have_nerd_font }
			sl.section_location = function () return "%21:%-2v" end
		end,
	},
}
