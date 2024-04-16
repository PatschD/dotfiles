-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--
-- lvim.use_icons = false

lvim.builtin.cmp.experimental.ghost_text = true

local keymap = vim.keymap.set
local opts = { silent = true }

-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", ":BufferKill<CR>", opts)

vim.keymap.set("n", "<Space>lg", "<cmd>lua require('zippy').insert_print()<CR>")
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

lvim.builtin.terminal.open_mapping = "<c-t>"
lvim.builtin.alpha.active = false

lvim.colorscheme = "kanagawa"

vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
vim.opt.relativenumber = true     -- relative line numbers

vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1             -- more space in the neovim command line for displaying messages
vim.opt.conceallevel = 0          -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"    -- the encoding written to a file
vim.opt.termguicolors = true      -- set term gui colors (most terminals support this)
vim.opt.expandtab = true          -- convert tabs to spaces
vim.opt.shiftwidth = 2            -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2               -- insert 2 spaces for a tab
vim.opt.numberwidth = 2           -- set number column width to 2 {default 4}



vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})


-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  { name = "black" },
  {
    name = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespace
    -- options such as `--line-width 80` become either `{"--line-width", "80"}` or `{"--line-width=80"}`
    args = { "--print-width", "100" },
    ---@usage only start in these filetypes, by default it will attach to all filetypes it supports
    filetypes = { "typescript", "typescriptreact" },
  },
})

lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

lvim.plugins = {
  { "rebelot/kanagawa.nvim" },
  { "folke/tokyonight.nvim" },
  { "tpope/vim-surround" },
  { "PatschD/zippy.nvim" },
  { "mfussenegger/nvim-dap-python" },
  { "nvim-treesitter/playground" },
  { "catppuccin/nvim",             name = "catppuccin", priority = 1000 },
  {
    "j-hui/fidget.nvim",
    opts = {
      -- options
    },
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require 'nordic'.load()
    end
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
}

table.insert(lvim.plugins, {
  "ray-x/lsp_signature.nvim",
  event = "BufRead",
  config = function()
    require("lsp_signature").on_attach({ hint_prefix = "" })
  end,
})

table.insert(lvim.plugins, {
  "zbirenbaum/copilot-cmp",
  event = "InsertEnter",
  dependencies = { "zbirenbaum/copilot.lua" },
  config = function()
    vim.defer_fn(function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })                             -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
      require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
    end, 100)
  end,
})

local dap = require("dap-python")
dap.setup("/Users/dapats/anaconda3/bin/python")
