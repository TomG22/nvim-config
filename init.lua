-- formatting options
vim.o.nu = true
vim.o.rnu = true
vim.o.ts = 4
vim.o.sw = 4
vim.o.undofile = true
vim.o.swapfile = false
vim.o.expandtab = true
vim.o.wrap = false

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "h"},
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "make",
  callback = function()
    vim.opt_local.expandtab = false
  end,
})

-- vim binds
vim.g.mapleader = " "
local map = vim.keymap.set

map('n', '<Tab>', ':tabn<CR>')
map('n', '<S-Tab>', ':tabp<CR>')
map('n', '<Down>', '<C-w>j')
map('n', '<Up>', '<C-w>k')
map('n', '<Left>', '<C-w>h')
map('n', '<Right>', '<C-w>l')
map('n', '<leader>bn', ':bnext<CR>')
map('n', '<leader>bp', ':bprev<CR>')
map('n', '<leader>o', ':tabe ')
map('n', '<leader>lt', ':tabe | b#<CR>')
map('n', '<leader>lb', ':e #<CR>')
map('n', '<leader>h', ':sp<CR>')
map('n', '<leader>v', ':vs<CR>')
map('n', '<leader>lh', ':sf #<CR>')
map('n', '<leader>lv', ':vs #<CR>')
map('n', '<leader>q', ':quit<CR>')
map('n', '<leader>w', ':write<CR>')
map('n', '<leader>S', ':update<CR>:source<CR>')
map('n', '<leader>rr', ':restart<CR>')
map('n', '<leader>rf', 'gg=G<C-o>')
map('n', '<leader>rw', '"ayiw:.,$s/a//cg<Left><Left><Left>')
map('v', '<leader>rs', '"ay:.,$s/a//cg<Left><Left><Left>')
map('n', "<Esc>", ":noh<CR>", { silent = true })
map({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
map({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')

-- plugins install
vim.pack.add({
  { src = "git@github.com:stevearc/oil.nvim" },
  { src = "git@github.com:echasnovski/mini.pick" },
  { src = "git@github.com:nvim-treesitter/nvim-treesitter" },
  { src = "git@github.com:hrsh7th/nvim-cmp" },
  { src = "git@github.com:hrsh7th/cmp-nvim-lsp" },
  { src = "git@github.com:hrsh7th/cmp-buffer" },
  { src = "git@github.com:hrsh7th/cmp-path" },
  { src = "git@github.com:saadparwaiz1/cmp_luasnip" },
  { src = "git@github.com:L3MON4D3/LuaSnip" },
  { src = "git@github.com:neovim/nvim-lspconfig" },
  { src = "git@github.com:mason-org/mason.nvim" },
  { src = "git@github.com:williamboman/mason-lspconfig.nvim" },
  { src = "git@github.com:ThePrimeagen/vim-be-good" },
  { src = "git@github.com:obsidian-nvim/obsidian.nvim" },

  -- colorschemes
  { src = "git@github.com:ayu-theme/ayu-vim" },
  { src = "git@github.com:erikbackman/brightburn.vim" },
  { src = "git@github.com:catppuccin/nvim" },
  { src = "git@github.com:ellisonleao/gruvbox.nvim" },
  { src = "git@github.com:polachok/nvim-mariana" },
  { src = "git@github.com:rose-pine/neovim" },
  { src = "git@github.com:navarasu/onedark.nvim" },
  { src = "git@github.com:nyoom-engineering/oxocarbon.nvim" },
  { src = "git@github.com:junegunn/seoul256.vim" },
  { src = "git@github.com:folke/tokyonight.nvim" },
  { src = "git@github.com:vague2k/vague.nvim" },
  { src = "git@github.com:Mofiqul/vscode.nvim" },
  { src = "git@github.com:rktjmp/lush.nvim" },
  { src = "git@github.com:zenbones-theme/zenbones.nvim" }
})

-- file explorer
require "oil".setup()
map('n', '<leader>e', ':Oil<CR>')

-- fzf
require "mini.pick".setup()
map('n', '<leader>pf', ':Pick files<CR>')
map('n', '<leader>pg', ':Pick grep_live<CR>')
map('n', '<leader>ph', ':Pick help<CR>')

-- treesitter
require "nvim-treesitter.configs".setup({
  ensure_installed = { "cpp", "lua", "java", "javascript"},
  sync_install = true,
  auto_install = true,
  ignore_install = {},
  highlight = { enable = true },
  modules = {},
})

-- auto completions
local cmp = require("cmp")
cmp.setup({
  preselect = cmp.PreselectMode.None,
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Down>'] = cmp.mapping.select_next_item(),
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'luasnip' },
  },
})

-- lsp manager
require "mason".setup()
require "mason-lspconfig".setup({
  ensure_installed = { "clangd", "lua_ls", "jdtls", "tinymist", "ts_ls" },
  automatic_installation = true,
  automatic_enable = true,
})

-- lsp
vim.lsp.config("lua_ls", {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  settings = {
    Lua = {
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
        }
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      }
    }
  }
})

vim.lsp.config("ts_ls", {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
  end
})

vim.lsp.config("clangd", {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  cmd = {
    "clangd",
    "--fallback-style=none"
  }
})


-- appearance
require "colors"
vim.cmd("colorscheme rose-pine")

vim.o.winborder = "rounded"
vim.o.signcolumn = 'yes'
vim.opt.colorcolumn = "70"
vim.o.termguicolors = true

map("n", "<leader>cc", function()
  vim.opt.colorcolumn = (#vim.opt.colorcolumn:get() > 0) and {} or { "70" }
end, { desc = "Toggle colorcolumn 70" })

local trans = require "trans"

map('n', '<leader>tx', function()
  trans.toggle_vim_trans()
end)

map('n', '<leader>tz', function()
  trans.toggle_all_trans()
end)

local trans_group = vim.api.nvim_create_augroup("Transparency", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  group = trans_group,
  callback = function()
    if trans.is_bg_trans then
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
    end
  end,
})
