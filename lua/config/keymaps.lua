local km = vim.keymap

-- clear highlights
km.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- diagnostics
km.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open Diagnostic [Q]uickfix list" })

-- window movement km.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
km.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
km.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
km.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })


-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local map = function(mode, keys, func, desc)
			mode = mode or "n"
			km.set(mode, keys, func, { buffer = bufnr, desc = desc })
		end

		--map("n", "K", vim.lsp.buf.hover, "LSP Hover")
		map("n", "gd", vim.lsp.buf.definition, "Go to definition")
		map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
		map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
		map("n", "gr", vim.lsp.buf.references, "References")
		map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
		map({ "n", "v", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
		map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")
	end,
})


-- Telescope
local builtin = require "telescope.builtin"
km.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
km.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
km.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
km.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
km.set({ "n", "v" }, "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
km.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
km.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
km.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
km.set("n", "<leader>s.", builtin.oldfiles, { desc = "[S]earch Recent Files (\".\" for repeat)" })
km.set("n", "<leader>sc", builtin.commands, { desc = "[S]earch [C]ommands" })
km.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("telescope-lsp-attach", { clear = true }),
	callback = function(event)
		local buf = event.buf

		-- Find references for the word under your cursor.
		km.set("n", "grr", builtin.lsp_references, { buffer = buf, desc = "[G]oto [R]eferences" })

		-- Jump to the implementation of the word under your cursor.
		-- Useful when your language has ways of declaring types without an actual implementation.
		km.set("n", "gri", builtin.lsp_implementations, { buffer = buf, desc = "[G]oto [I]mplementation" })

		-- Jump to the definition of the word under your cursor.
		-- This is where a variable was first declared, or where a function is defined, etc.
		-- To jump back, press <C-t>.
		km.set("n", "grd", builtin.lsp_definitions, { buffer = buf, desc = "[G]oto [D]efinition" })

		-- Fuzzy find all the symbols in your current document.
		-- Symbols are things like variables, functions, types, etc.
		km.set("n", "gO", builtin.lsp_document_symbols, { buffer = buf, desc = "Open Document Symbols" })

		-- Fuzzy find all the symbols in your current workspace.
		-- Similar to document symbols, except searches over your entire project.
		km.set("n", "gW", builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = "Open Workspace Symbols" })

		-- Jump to the type of the word under your cursor.
		-- Useful when you"re not sure what type a variable is and you want to see
		-- the definition of its *type*, not where it was *defined*.
		km.set("n", "grt", builtin.lsp_type_definitions, { buffer = buf, desc = "[G]oto [T]ype Definition" })
	end,
})

km.set("n", "<leader>/", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
		winblend = 10,
		previewer = false,
	})
end, { desc = "[/] Fuzzily search in current buffer" })

km.set("n", "<leader>s/", function()
	builtin.live_grep {
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	}
end, { desc = "[S]earch in Open Files" }
)


-- Oil
km.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory (Oil)" })


-- harpoon
local harpoon = require("harpoon")
harpoon:setup()

km.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add Buffer to Harpoon" })
km.set("n", "<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon Quick Menu" })
for i = 1, 10, 1 do
	-- set for 1 to 10
	km.set("n", "<C-" .. i .. ">", function() harpoon:list():select(i) end, { desc = "Harpoon (" .. i .. ")" })
end
km.set("n", "<leader>p", function() harpoon:list():prev() end, { desc = "Harpoon previous" })
km.set("n", "<leader>n", function() harpoon:list():next() end, { desc = "Harpoon next" })

-- harpoon + telescope
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	require("telescope.pickers").new({}, {
		prompt_title = "Harpoon",
		finder = require("telescope.finders").new_table({
			results = file_paths,
		}),
		previewer = conf.file_previewer({}),
		sorter = conf.generic_sorter({}),
	}):find()
end

km.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })
