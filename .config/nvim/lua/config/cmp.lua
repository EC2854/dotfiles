vim.pack.add({
    { src = "https://github.com/Saghen/blink.cmp" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/windwp/nvim-autopairs" },
})
require("nvim-autopairs").setup()
require("blink.cmp").setup({
    fuzzy = { implementation = "lua" },
    sources = {
        default = { 'snippets', 'lsp', 'buffer', 'path' },
    },
    completion = {
        ghost_text = {
            enabled = false,
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
        },
    },
    cmdline = {
        completion = {
            menu = {
                auto_show = true
            }
        }
    },
    keymap = {
        ['<CR>'] = { 'accept', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
        ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
    },
    signature = { enabled = true }
})
