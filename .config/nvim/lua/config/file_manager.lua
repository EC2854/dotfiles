vim.pack.add({
    { src = "https://github.com/stevearc/oil.nvim" },
})

require("oil").setup({
    default_file_explorer = true,
    columns = {
        "icon",
    },
    float = {
        preview_split = "right",
        win_options = {
            number = true,
            relativenumber = true,
            signcolumn = "no",
            cursorline = true,
        }
    },
    delete_to_trash = false,
    keymaps = {
        ["."] = { "actions.cd", mode = "n" },
        ["h"] = { "actions.parent", mode = "n" },
        ["l"] = { "actions.select", mode = "n" },
    },
})
vim.api.nvim_create_autocmd("User", {
    pattern = "OilEnter",
    callback = vim.schedule_wrap(function(args)
        local oil = require("oil")
        if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
            oil.open_preview()
        end
    end),
})
