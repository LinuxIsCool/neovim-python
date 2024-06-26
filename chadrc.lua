-- Set Leader Key
vim.g.mapleader = ","

-- Set Vim Options

-- No wrap line
vim.opt.wrap = false

-- Highlight the cursor line
vim.opt.cursorline = true

-- Set Spell on by Default
vim.opt.spell = true

-- Auto Indenting
vim.opt.autoindent = true
vim.opt.smartindent = true

local highlights = require "custom.highlights"

---@type ChadrcConfig 
 local M = {}
 M.ui = {
  theme = 'catppuccin',transparency = false,
  hl_override = highlights.override,
  hl_add = highlights.add,
}
 M.plugins = "custom.plugins"
 M.mappings = require "custom.mappings"
 
 return M
