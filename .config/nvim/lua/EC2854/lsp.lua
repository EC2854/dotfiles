vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
})

vim.lsp.enable({ "lua_ls", "bashls" })
require("mason").setup()

vim.diagnostic.config({
    virtual_text = true,
})
