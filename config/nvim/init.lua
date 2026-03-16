-- =============================================================================
-- init.lua — Minimal Neovim config (backup editor)
-- =============================================================================

-- ── Options ──────────────────────────────────────────────────────────────────
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.tabstop        = 4
vim.opt.shiftwidth     = 4
vim.opt.expandtab      = true
vim.opt.smartindent    = true
vim.opt.wrap           = false
vim.opt.hlsearch       = false
vim.opt.incsearch      = true
vim.opt.termguicolors  = true
vim.opt.scrolloff      = 8
vim.opt.updatetime     = 50
vim.opt.colorcolumn    = "100"
vim.opt.clipboard      = "unnamedplus"   -- use system clipboard

-- ── Leader key ───────────────────────────────────────────────────────────────
vim.g.mapleader = " "

-- ── Key mappings ─────────────────────────────────────────────────────────────
local map = vim.keymap.set

map("n", "<leader>e", vim.cmd.Ex)                         -- file explorer
map("n", "<C-d>", "<C-d>zz")                              -- keep cursor centered
map("n", "<C-u>", "<C-u>zz")
map("v", "J", ":m '>+1<CR>gv=gv")                        -- move lines up/down
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "<leader>y", '"+y')                               -- yank to system clipboard
map("n", "<leader>p", '"+p')                               -- paste from system clipboard
map("n", "Q", "<nop>")                                    -- disable Ex mode

-- ── Plugin manager (lazy.nvim) ────────────────────────────────────────────────
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function() vim.cmd.colorscheme("catppuccin-mocha") end,
  },
  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>" },
    },
  },
  -- Treesitter (syntax highlighting)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "python", "lua", "json", "yaml", "markdown", "bash" },
        highlight = { enable = true },
      })
    end,
  },
  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lsp = require("lspconfig")
      lsp.pyright.setup({})     -- pip install pyright or npm install -g pyright
      lsp.ruff_lsp.setup({})    -- pip install ruff-lsp
    end,
  },
})
