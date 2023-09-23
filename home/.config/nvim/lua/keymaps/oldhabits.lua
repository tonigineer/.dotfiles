local function set(mode, lhs, rhs, options)
    vim.keymap.set(mode, lhs, rhs, options)
end



-- [[ Normal mode ]]
set("n", "<C-z>", ":u<Return>", { silent = true })              --[[Undo]]
set("n", "<C-y>", "<C-R><Return>", { silent = true })           --[[Redo]]
set("n", "<C-s>", ":w!<Return>", { silent = true })             --[[Save]]
set("n", "<C-a>", "gg<S-v>G", { silent = true })                --[[Select all]]


-- [[ Insert mode ]]
set("i", "jk", "<ESC>", { nowait = true })                      --[[Get back to normal mode]]
set("i", "kj", "<ESC>", { nowait = true })

set("i", "<C-z>", "<Esc>:u<Return>", { silent = true })         --[[Undo]]
set("i", "<C-y>", "<C-R><Return>", { silent = true })           --[[Redo]]
set("i", "<C-s>", "<Esc>:w!<Return>", { silent = true })        --[[Save]]
