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
options.colorcolumn = ""
options.number = true
options.relativenumber = true
options.scrolloff = 8
options.signcolumn = "yes"

-- [[ Filetypes ]]
options.encoding = "utf8"

-- [[ Theme ]]
options.syntax = "ON"
options.termguicolors = true

-- [[ Search ]]
options.ignorecase = true
options.smartcase = true
options.incsearch = true
options.hlsearch = false

-- [[ Whitespace ]]
options.expandtab = false
options.shiftwidth = 4
options.softtabstop = 4
options.tabstop = 4
options.fillchars:append { eob = " " }

-- [[ Splits ]]
options.splitright = false
options.splitbelow = false

-- [[ Mouse ]]
options.mouse = ""