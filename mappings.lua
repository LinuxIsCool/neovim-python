local M = {}

M.disabled = {
  n = {
    ["<leader>f"] = "",
    ["<leader>ff"] = "",
    ["<leader>fg"] = "",
    ["<leader>fb"] = "",
    ["<leader>fh"] = "",
    ["<leader>fa"] = "",
    ["<leader>fm"] = "",
    ["<leader>fo"] = "",
    ["<leader>fw"] = "",
    ["<leader>fz"] = "",
    ["<leader>j"] = "",
    ["<leader>r"] = "",
    ["j"] = "",
    ["k"] = "",
  },
}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>f"] = { "0", "go to start of line", opts = { nowait = true } },
    ["<leader>j"] = { "$", "go to end of line", opts = { nowait = true } },
    ["tt"] = { ":lua require('base46').toggle_transparency()<cr>", "toggle transparency", opts = { nowait = true } },
    ["<leader>u"] = { ":UndotreeToggle<CR>" },
    ["j"] = { "j" },
    ["k"] = { "k" },
  },
  v = {
    ["<leader>f"] = { "0", "go to start of line", opts = { nowait = true } },
    ["<leader>j"] = { "$", "go to end of line", opts = { nowait = true } },
    ["<C-c>"] = { '"+y', "copy selection to clipboard", opts = { noremap = true, silent = true } },
    ["<C-v>"] = { '"+p', "paste from clipboard", opts = { noremap = true, silent = true } },
  },
  i = {
    ["<C-v>"] = { "<C-r>+", "paste from clipboard", opts = { noremap = true, silent = true } },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {"<cmd> DapToggleBreakpoint <CR>"}
  }
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require('dap-python').test_method()
      end
    }
  }
}

return M
