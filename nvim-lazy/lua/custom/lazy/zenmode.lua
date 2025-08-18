return {
    "folke/zen-mode.nvim",
    config = function()
        vim.keymap.set("n", "<leader>zz", function()
            require("zen-mode").setup {
                window = {
                    width = 0.75,
                    height = 1,
                    options = {
                        signcolumn = "no",
                        number = false,
                        relativenumber = false,
                        cursorline = false,
                        foldcolumn = "0",
                        list = false,
                        wrap = true,
                    }
                },
                plugins = {
                    twilight = { enabled = true, dimming = 0.25 },
                },
             }
            require("zen-mode").toggle()
            vim.wo.wrap = false
            vim.wo.number = true
            vim.wo.rnu = false
            vim.opt.colorcolumn = "0"
        end)
    end
}
