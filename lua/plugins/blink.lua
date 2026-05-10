return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"saghen/blink.lib",
			"rafamadriz/friendly-snippets",
		},
		build = function()
			require("blink.cmp").build():wait(60000)
		end,

		opts = {
			keymap = { preset = "default" },
			completion = { documentation = { auto_show = false, auto_show_delay_ms = 500 } },
			sources = { default = { "lsp", "path", "snippets", "buffer" } },
			fuzzy = { implementation = "rust" },
			appearance = { nerd_font_variant = "mono" },
			signature = { enabled = true },
		},
	}
}
