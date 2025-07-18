local options = {
    number = true,
    relativenumber = true,
    cursorline = true,
    wrap = true,
    scrolloff = 8,
    sidescrolloff = 8,

    tabstop = 4,
    shiftwidth = 4,
    softtabstop = 4,
    expandtab = true,
    smartindent = true,
    autoindent = true,

    ignorecase = true,
    smartcase = true,      
    hlsearch = true,
    incsearch = true,

    termguicolors = true,
    signcolumn = "yes",
    showmatch = true,
    matchtime = 2,
    cmdheight = 1,
    completeopt = { "menuone","noinsert","noselect" },
    showmode = false,
    pumheight = 10,
    pumblend = 10,
    winblend = 0,
    conceallevel = 0,
    concealcursor = "",
    lazyredraw = true,
    synmaxcol = 300,

    backup = false,
    writebackup = false,
    swapfile = false,
    undofile = true,
    updatetime = 300,
    timeoutlen = 500,
    ttimeoutlen = 0,
    autoread = true,
    autowrite = false,

    autochdir = false,
    hidden = true,
    errorbells = false,
    backspace = {"indent","eol","start"},
    selection = "exclusive",
    mouse = "a",
    modifiable = true,
    clipboard = "unnamedplus",
    encoding = "UTF-8",

    splitbelow = true,
    splitright = true,
}

vim.opt.iskeyword:append("-")
vim.opt.path:append("**")

vim.opt.shortmess:append "c"
vim.loader.enable()

for k, v in pairs(options) do
    vim.opt[k] = v
end
