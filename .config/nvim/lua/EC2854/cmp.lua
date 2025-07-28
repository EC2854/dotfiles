vim.pack.add({
    { src = "https://github.com/Saghen/blink.cmp" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
})
require("blink.cmp").setup({
    fuzzy = { implementation = "lua" },
    sources = {
        default = { 'lsp', 'buffer', 'snippets', 'path' },
    },
    completion = {
        ghost_text = {
            enabled = true
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
        },
    },
    keymap = {
        ['<Tab>'] = {
            function(cmp)
                if cmp.snippet_active() then
                    return cmp.accept()
                else
                    return cmp.select_and_accept()
                end
            end,
            'snippet_forward',
            'fallback'
        },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
        ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
    },
})
