local terminal_state = {
    buf = nil,
    win = nil,
    is_open = false,
}

local function create_floating_window()
    local width        = math.floor(vim.o.columns * 0.8)
    local height       = math.floor(vim.o.lines * 0.8)
    local row          = math.floor((vim.o.lines - height) / 2)
    local col          = math.floor((vim.o.columns - width) / 2)

    terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
    })
end

local function FloatingTerminal()
    if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
        return
    end

    if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
        terminal_state.buf = vim.api.nvim_create_buf(false, true)
        vim.bo[terminal_state.buf].bufhidden = "hide"
    end

    create_floating_window()

    local lines = vim.api.nvim_buf_get_lines(terminal_state.buf, 0, -1, false)
    if #lines == 0 or (#lines == 1 and lines[1] == "") then
        vim.fn.termopen(vim.o.shell or os.getenv("SHELL"))
    end

    terminal_state.is_open = true
    vim.cmd("startinsert")

    vim.api.nvim_create_autocmd("BufLeave", {
        buffer = terminal_state.buf,
        callback = function()
            if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
                vim.api.nvim_win_close(terminal_state.win, false)
                terminal_state.is_open = false
            end
        end,
        once = true,
    })
end

local function CloseFloatingTerminal()
    if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
    end
end

-- Keybinds
vim.keymap.set({ "n", "t" }, "<C-t>", FloatingTerminal, { desc = "Toggle floating terminal (Ctrl+t)" })
vim.keymap.set("n", "<leader>tt", FloatingTerminal, { desc = "Toggle floating terminal" })
vim.keymap.set("t", "<Esc>", function()
    local curr_buf = vim.api.nvim_get_current_buf()

    if terminal_state.is_open and terminal_state.buf == curr_buf then
        CloseFloatingTerminal()
    else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
    end
end, { desc = "Close floating terminal or exit terminal mode" })

return {
    toggle = FloatingTerminal,
    close = CloseFloatingTerminal,
}
