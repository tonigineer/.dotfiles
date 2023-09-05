local builtin = require('telescope.builtin')
local M = {}

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

-- Custom mappings
M.toni = {
  v = {
    ["<C-z>"] = { ":u<Return>", "Undo (Old habits)" , opts = { silent = true }},
    ["<C-y>"] = { "<C-R><Return>", "Redo (Old habits)" , opts = { silent = true }},
    ["<C-s>"] = { ":w!<Return>", "Save (Old habits)" , opts = { silent = true }},
  },

  n = {
    ["<C-z>"] = { ":u<Return>", "Undo (Old habits)" , opts = { silent = true }},
    ["<C-y>"] = { "<C-R><Return>", "Redo (Old habits)" , opts = { silent = true }},
    ["<C-s>"] = { ":w!<Return>", "Save (Old habits)" , opts = { silent = true }},
    ["<C-a>"] = { "gg<S-v>G", "Select all (Old habits)"},
    ["<leader>pf"] = { builtin.find_files, "Telescope (Files)", opts = { }},
    ["<leader>pg"] = { builtin.git_files, "Telescope (Git files)", opts = { }},
    ["<C-R>"] = {"<Cmd>lua require('nvterm.terminal').send('python ' .. vim.fn.expand('%') .. '\\r', 'float')<CR>", "Run current Python file in terminal"},
    ["<C-W>"] = {":bd!<CR>", "Close current buffer"}
  },

  i = {
    ["jk"] = { "<ESC>", "escape insert mode" , opts = { nowait = true }},
    ["kj"] = { "<ESC>", "escape insert mode" , opts = { nowait = true }},
    ["<C-z>"] = { "<Esc>:u<Return>", "Undo (Old habits)" , opts = { silent = true }},
    ["<C-y>"] = { "<C-R><Return>", "Redo (Old habits)" , opts = { silent = true }},
    ["<C-s>"] = { "<Esc>:w!<Return>", "Save (Old habits)" , opts = { silent = true }},
  }
}

return M
