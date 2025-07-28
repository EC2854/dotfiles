vim.cmd("set completeopt+=noselect")

vim.pack.add({
    { src = "https://github.com/ibhagwan/fzf-lua" },
})

require("EC2854.cmp")
require("EC2854.colorscheme")
require("EC2854.lsp")
require("EC2854.opts")
require("EC2854.terminal")
require("EC2854.treesitter")

require("EC2854.keybinds")
