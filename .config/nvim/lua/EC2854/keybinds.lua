local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local bind = vim.api.nvim_set_keymap

--Remap space as leader key
bind("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
bind("n", "<C-h>", "<C-w>h", opts)
bind("n", "<C-j>", "<C-w>j", opts)
bind("n", "<C-k>", "<C-w>k", opts)
bind("n", "<C-l>", "<C-w>l", opts)


-- center 
bind("n", "n", "nzzzv", { desc = "Next search result (centered)" })
bind("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
bind("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
bind("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Resize
bind("n", "<A-h>", ":vertical resize +2<CR>", opts)
bind("n", "<A-j>", ":resize -2<CR>", opts)
bind("n", "<A-k>", ":resize +2<CR>", opts)
bind("n", "<A-l>", ":vertical resize -2<CR>", opts)

-- buffers
bind("n", "X", ":Bdelete<CR>", opts)

-- Visual --
-- Stay in indent mode
bind("v", "<", "<gv", opts)
bind("v", ">", ">gv", opts)

-- Move text up and down
bind("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
bind("x", "J", ":move '>+1<CR>gv-gv", opts)
bind("x", "K", ":move '<-2<CR>gv-gv", opts)

bind("v", "j", "gj", opts)
bind("v", "k", "gk", opts)
-- Terminal --
-- Better terminal navigation
bind("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
bind("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
bind("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
bind("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
