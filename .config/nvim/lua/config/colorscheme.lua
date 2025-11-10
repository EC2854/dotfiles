vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim" }
})
require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = true,
    float = {
        transparent = true,
    },
    term_colors = true,
    dim_inactive = { enabled = false, },
    no_italic = false,
    no_bold = false,
    no_underline = false,
    integrations = {
        treesitter = true,
        rainbow_delimiters = true,
        which_key = true,
    },
    color_overrides = {
        mocha = {
            base = "#0d0d14",
            blue = "#ac3231",
            crust = "#121318",
            flamingo = "#f2cdcd",
            green = "#a6e3a1",
            lavender = "#b4befe",
            mantle = "#1b1424",
            maroon = "#eba0ac",
            mauve = "#cba6f7",
            overlay0 = "#6c7086",
            overlay1 = "#7f849c",
            overlay2 = "#9399b2",
            peach = "#fab387",
            pink = "#f5c2e7",
            red = "#ffb4ab",
            rosewater = "#f5e0dc",
            sapphire = "#74c7ec",
            sky = "#89dceb",
            subtext0 = "#c5c6d0",
            subtext1 = "#c5c6d0",
            surface0 = "#1b1424",
            surface1 = "#52263e",
            surface2 = "#52263e",
            teal = "#94e2d5",
            text = "#e3e2e9",
            yellow = "#f9e2af"
        },
    },
    custom_highlights = function(colors)
        return {
            CursorLineNr = { fg = colors.blue },
            AlphaButtons = { fg = colors.blue },
            AlphaHeader = { fg = colors.blue }
        }
    end
})
vim.cmd("colorscheme catppuccin")
