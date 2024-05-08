
local plugins = {
  {
    "nvim-neotest/nvim-nio",
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      require("core.utils").load_mappings("dap_python")
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    ft = {"python"},
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- python
        "black",
        "debugpy",
        "mypy",
        "ruff-lsp",
        "pyright",

        -- lua stuff
        "lua-language-server",
        "stylua",

        -- web dev stuff
        "css-lsp",
        "html-lsp",
        "typescript-language-server",
        "deno",
        "prettier",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    ensure_installed = {
      "python",
      "vim",
      "lua",
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",
      "c",
      "markdown",
      "markdown_inline",
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      filters = {
        dotfiles = false,
        exclude = { vim.fn.stdpath "config" .. "/lua/custom" },
      },
      disable_netrw = true,
      hijack_netrw = true,
      hijack_cursor = true,
      hijack_unnamed_buffer_when_opening = true,
      sync_root_with_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      view = {
        adaptive_size = false,
        side = "left",
        width = 30,
        preserve_window_proportions = true,
      },
      git = {
        enable = true,
        ignore = true,
      },
      filesystem_watchers = {
        enable = true,
      },
      actions = {
        open_file = {
          resize_window = true,
        },
      },
      renderer = {
        root_folder_label = true,
        highlight_git = true,
        highlight_opened_files = "icon",

        indent_markers = {
          enable = false,
        },

        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },

          glyphs = {
            default = "󰈚",
            symlink = "",
            folder = {
              default = "",
              empty = "",
              empty_open = "",
              open = "",
              symlink = "",
              symlink_open = "",
              arrow_open = "",
              arrow_closed = "",
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },
    },
    on_attach = function(bufnr)
      local api = require "nvim-tree.api"

      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- BEGIN_DEFAULT_ON_ATTACH
      vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts "CD")
      vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer, opts "Open: In Place")
      vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts "Info")
      vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts "Rename: Omit Filename")
      vim.keymap.set("n", "<C-t>", api.node.open.tab, opts "Open: New Tab")
      vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts "Open: Vertical Split")
      vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts "Open: Horizontal Split")
      vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts "Close Directory")
      vim.keymap.set("n", "<CR>", api.node.open.edit, opts "Open")
      vim.keymap.set("n", "<Tab>", api.node.open.preview, opts "Open Preview")
      vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts "Next Sibling")
      vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts "Previous Sibling")
      vim.keymap.set("n", ".", api.node.run.cmd, opts "Run Command")
      vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts "Up")
      vim.keymap.set("n", "a", api.fs.create, opts "Create")
      vim.keymap.set("n", "bd", api.marks.bulk.delete, opts "Delete Bookmarked")
      vim.keymap.set("n", "bmv", api.marks.bulk.move, opts "Move Bookmarked")
      vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter, opts "Toggle Filter: No Buffer")
      vim.keymap.set("n", "c", api.fs.copy.node, opts "Copy")
      vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter, opts "Toggle Filter: Git Clean")
      vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts "Prev Git")
      vim.keymap.set("n", "]c", api.node.navigate.git.next, opts "Next Git")
      vim.keymap.set("n", "d", api.fs.remove, opts "Delete")
      vim.keymap.set("n", "D", api.fs.trash, opts "Trash")
      vim.keymap.set("n", "E", api.tree.expand_all, opts "Expand All")
      vim.keymap.set("n", "e", api.fs.rename_basename, opts "Rename: Basename")
      vim.keymap.set("n", "]e", api.node.navigate.diagnostics.next, opts "Next Diagnostic")
      vim.keymap.set("n", "[e", api.node.navigate.diagnostics.prev, opts "Prev Diagnostic")
      vim.keymap.set("n", "F", api.live_filter.clear, opts "Clean Filter")
      vim.keymap.set("n", "f", api.live_filter.start, opts "Filter")
      vim.keymap.set("n", "g?", api.tree.toggle_help, opts "Help")
      vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts "Copy Absolute Path")
      vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts "Toggle Filter: Dotfiles")
      vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts "Toggle Filter: Git Ignore")
      vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts "Last Sibling")
      vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts "First Sibling")
      vim.keymap.set("n", "m", api.marks.toggle, opts "Toggle Bookmark")
      vim.keymap.set("n", "o", api.node.open.edit, opts "Open")
      vim.keymap.set("n", "O", api.node.open.no_window_picker, opts "Open: No Window Picker")
      vim.keymap.set("n", "p", api.fs.paste, opts "Paste")
      vim.keymap.set("n", "P", api.node.navigate.parent, opts "Parent Directory")
      vim.keymap.set("n", "q", api.tree.close, opts "Close")
      vim.keymap.set("n", "r", api.fs.rename, opts "Rename")
      vim.keymap.set("n", "R", api.tree.reload, opts "Refresh")
      vim.keymap.set("n", "s", api.node.run.system, opts "Run System")
      vim.keymap.set("n", "S", api.tree.search_node, opts "Search")
      vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts "Toggle Filter: Hidden")
      vim.keymap.set("n", "W", api.tree.collapse_all, opts "Collapse")
      vim.keymap.set("n", "x", api.fs.cut, opts "Cut")
      vim.keymap.set("n", "y", api.fs.copy.filename, opts "Copy Name")
      vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts "Copy Relative Path")
      vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts "Open")
      vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts "CD")
      -- END_DEFAULT_ON_ATTACH
    end,
  },
  {
    "ibhagwan/fzf-lua",
    lazy = false,
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup {}
      vim.keymap.set("n", "fp", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
      vim.keymap.set("n", "fo", "<cmd>lua require('fzf-lua').oldfiles()<CR>", { silent = true })
      vim.keymap.set("n", "fg", "<cmd>lua require('fzf-lua').grep_project()<CR>", { silent = true })
      vim.keymap.set("n", "fb", "<cmd>lua require('fzf-lua').buffers()<CR>", { silent = true })
      vim.keymap.set("n", "fbl", "<cmd>lua require('fzf-lua').blines()<CR>", { silent = true })
      vim.keymap.set("n", "fl", "<cmd>lua require('fzf-lua').lines()<CR>", { silent = true })
      vim.keymap.set("n", "ff", "<cmd>lua require('fzf-lua').builtin()<CR>", { silent = true })
      vim.keymap.set("n", "fc", "<cmd>lua require('fzf-lua').command_history()<CR>", { silent = true })
      vim.keymap.set("n", "fj", "<cmd>lua require('fzf-lua').jumps()<CR>", { silent = true })

      -- Add Ctrl+R in command mode to search command history using fzf-lua
      vim.keymap.set(
        "c",
        "<C-r>",
        "<C-c><cmd>lua require('fzf-lua').command_history()<CR>",
        { noremap = true, silent = true }
      )
    end,
  },
  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    lazy = false,
    config = function()
      vim.g.codeium_no_map_tab = 1
      vim.keymap.set("i", "<C-f>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true })
      vim.keymap.set("i", "<C-g>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true })
      vim.keymap.set("i", "<C-o>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true })
      vim.keymap.set("i", "<C-i>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true })
      vim.keymap.set("i", "<C-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true })
    end,
  },

-- Readline in vim!
  { "tpope/vim-rsi",        lazy = false },

  -- Smooth scrolling in vim :)
  { "psliwka/vim-smoothie", lazy = false },


  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    -- build = "cd app && yarn install",
    build = ":call mkdp#util#install()",
  },
  {
    "LintaoAmons/scratch.nvim",
    event = "VeryLazy",
  },
}

return plugins
