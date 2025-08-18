local M = {}

M.isTransparent = false

function M.apply_transparency()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
end

function M.reset_colorscheme()
    vim.cmd("colorscheme seoul256")
end

function M.sync_vim_transparency()
    M.reset_colorscheme()

    if M.isTransparent then
        M.apply_transparency()
    end
end

function M.sync_cmd_transparency()
    if M.isTransparent then
        vim.fn.system("set_cmd_opacity 50")
    else
        vim.fn.system("set_cmd_opacity 100")
    end
end

return M
