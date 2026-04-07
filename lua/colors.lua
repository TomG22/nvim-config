-- catppuccin
pcall(function()
    require("catppuccin").setup({
        flavour = "mocha",
        styles = {
            comments = { "italic" },
            conditionals = {},
            loops = {},
            functions = {},
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
            operators = {},
            miscs = {},
        },
    })
end)

-- gruvbox
pcall(function()
    require("gruvbox").setup({
        terminal_colors = true,
        undercurl = true,
        underline = false,
        bold = true,
        italic = {
            strings = false,
            emphasis = false,
            comments = false,
            operators = false,
            folds = false,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true,
        contrast = "",
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
    })
end)

-- onedark
pcall(function()
    require("onedark").setup({
        style = "darker"
    })
end)

-- rose-pine
pcall(function()
    require("rose-pine").setup({
        styles = {
            bold = false,
            italic = false,
        },
    })
end)

-- seoul256
pcall(function()
    vim.g.seoul256_background = 234
    vim.o.background = "dark"
end)

-- tokyonight
pcall(function()
    require("tokyonight").setup({
        terminal_colors = true,
        styles = {
            comments = { italic = false },
            keywords = { italic = false },
            floats = "dark",
        },
    })
end)

-- vague
pcall(function()
    require("vague").setup({
        italic = false,
    })
end)

-- vscode
pcall(function()
    vim.o.background = 'dark'
end)
