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
            base = "#121318",
            blue = "#b9c3ff",
            crust = "#121318",
            flamingo = "#f2cdcd",
            green = "#a6e3a1",
            lavender = "#b4befe",
            mantle = "#38393f",
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
            subtext0 = "#c6c5d0",
            subtext1 = "#c6c5d0",
            surface0 = "#292a2f",
            surface1 = "#34343a",
            surface2 = "#34343a",
            teal = "#94e2d5",
            text = "#e3e1e9",
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
