local km = vim.keymap

-- clear highlights
km.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- diagnostics
km.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open Diagnostic [Q]uickfix list" })

-- window movement
km.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
km.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
km.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
km.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })


-- LSP
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
    		local bufnr = args.buf
		local map = function(mode, keys, func, desc)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
		end

		map('n', 'K',  vim.lsp.buf.hover, 'LSP Hover')
		map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
		map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
		map('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')
		map('n', 'gr', vim.lsp.buf.references, 'References')
		map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
		map({ 'n', 'v', "x" }, '<leader>ca', vim.lsp.buf.code_action, 'Code action')
		map('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, 'Format buffer')
  	end,
})


