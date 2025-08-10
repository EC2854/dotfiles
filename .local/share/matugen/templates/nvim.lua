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
            base = "{{colors.surface.default.hex}}",
            blue = "{{colors.primary.default.hex}}",
            crust = "{{colors.surface_dim.default.hex}}",
            flamingo = "#f2cdcd",
            green = "#a6e3a1",
            lavender = "#b4befe",
            mantle = "{{colors.surface_bright.default.hex}}",
            maroon = "#eba0ac",
            mauve = "#cba6f7",
            overlay0 = "#6c7086",
            overlay1 = "#7f849c",
            overlay2 = "#9399b2",
            peach = "#fab387",
            pink = "#f5c2e7",
            red = "{{colors.error.default.hex}}",
            rosewater = "#f5e0dc",
            sapphire = "#74c7ec",
            sky = "#89dceb",
            subtext0 = "{{colors.on_surface_variant.default.hex}}",
            subtext1 = "{{colors.on_surface_variant.default.hex}}",
            surface0 = "{{colors.surface_container_high.default.hex}}",
            surface1 = "{{colors.surface_container_highest.default.hex}}",
            surface2 = "{{colors.surface_container_highest.default.hex}}",
            teal = "#94e2d5",
            text = "{{colors.on_surface.default.hex}}",
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
