local builtin = require("telescope.builtin")
local defaults = { silent = true, noremap = true }
local function set(lhs, rhs)
    vim.keymap.set("n", lhs, rhs, defaults)
end

set("<leader>ff", builtin.find_files)
set("<leader>fg", builtin.live_grep)
set("<leader>fb", builtin.buffers)
set("<leader>fh", builtin.help_tags)