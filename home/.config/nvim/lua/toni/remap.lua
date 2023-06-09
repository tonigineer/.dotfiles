vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Old habits die hard :)
vim.keymap.set('n', '<C-s>', ':w!<Return>', {silent=true})  -- save
vim.keymap.set('i', '<C-s>', '<Esc>:w!<Return>', {silent=true})

vim.keymap.set('i', '<C-z>', '<Esc>:u<Return>', {silent=true})  -- undo
vim.keymap.set('n', '<C-z>', ':u<Return>', {silent=true})
vim.keymap.set('v', '<C-z>', ':u<Return>', {silent=true})

vim.keymap.set('n', '<C-a>', 'gg<S-v>G')  -- select all

-- Shortcut to normal mode
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('i', 'kj', '<Esc>')

vim.keymap.set('n', 'x', '"_x')  -- prevent ctrl+x to exit vim (old habit too)

-- Delete a word backwards
vim.keymap.set('n', 'dw', 'vb"_d')
