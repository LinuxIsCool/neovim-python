-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  Comment = {
    italic = true,
    fg = "#7f7f7f",
  },
  CursorLine = { bg = "line" },
}

---@type HLTable
M.add = {
  NvimTreeOpenedFile = { fg = "purple", bold = true },
}

return M
