vim.pack.add({
    { src = "https://github.com/folke/which-key.nvim" },
})
require("which-key").setup({
    preset = "helix",
    show_help = false,
    show_keys = false,
})

vim.keymap.set("n", "<leader>/", function() require('fzf-lua').files() end, { desc = "Open File", nowait = true })
vim.keymap.set("n", "<leader>n", "<cmd>edit .<CR>", { desc = "File Manager", nowait = true })
vim.keymap.set("n", "<leader>u", function() vim.pack.update() end, { desc = "Update plugins", nowait = true })

vim.keymap.set("n", "<leader>fc", function() require('fzf-lua').zoxide() end, { desc = "Change directory (zoxide)", nowait = true })
vim.keymap.set("n", "<leader>fl", function() require('fzf-lua').live_grep() end, { desc = "Live grep", nowait = true })
vim.keymap.set("n", "<leader>fr", function() require('fzf-lua').oldfiles() end,  { desc = "Open recent file", nowait = true })

vim.keymap.set("n", "<leader>bi", function() require('fzf-lua').buffers() end, { desc = "ibuffer", nowait = true })
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next Buffer", nowait = true })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous Buffer", nowait = true })

vim.keymap.set("n", "<leader>tg", "<cmd>Gitsigns toggle_deleted<CR>", { desc = "Toggle Git Deleted", nowait = true })

vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { desc = "Format", nowait = true })
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { desc = "Smart rename", nowait = true })
vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition, { desc = "Go to definition", nowait = true })
vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, { desc = "Hover", nowait = true })

vim.keymap.set("v", "<leader>sn", ":!sort -n<CR>", { desc = "Numeric Sort", nowait = true })
vim.keymap.set("v", "<leader>sr", ":!sort -r<CR>", { desc = "Reverse Sort", nowait = true })
vim.keymap.set("v", "<leader>ss", ":!sort<CR>", { desc = "Sort", nowait = true })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h")
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j")
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k")
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l")

-- center
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Visual --
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
--
-- Move text up and down
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv", opts)
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv", opts)
