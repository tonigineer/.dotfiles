local function config(module)
    return require("keymaps."..module)
end

config("telescope")
