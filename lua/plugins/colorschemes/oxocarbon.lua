return {
	{
		"nyoom-engineering/oxocarbon.nvim",
		setup = function()
			if vim.g.transparent_bg then
				vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
				vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
				vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
			else
				vim.opt.background = "dark"
			end
		end
	}
}
