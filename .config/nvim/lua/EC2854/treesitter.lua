vim.pack.add({
    { src = "https://github.com/NvChad/nvim-colorizer.lua" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
    { src = "https://github.com/HiPhish/rainbow-delimiters.nvim" },
})
require "nvim-treesitter.configs".setup({
    highlight = { enable = true }
})
