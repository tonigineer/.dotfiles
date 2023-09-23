local options = vim.opt
local global = vim.g

global.mapleader = " "
global.maplocalleader = " "


-- [[ Checkhealth optionals]]
global.loaded_perl_provider = 0
global.loaded_ruby_provider = 0


-- [[ Default: Explorer ]]
vim.cmd([[
    nnoremap - :Explore<CR>
    autocmd FileType netrw setl bufhidden=delete
]])

global.netrw_banner=0
global.netrw_liststyle=3
global.netrw_bufsettings="noma nomod nu nobl nowrap ro"

-- [[ Context ]]