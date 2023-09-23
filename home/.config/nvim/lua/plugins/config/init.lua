local function config(module)
    return require("plugins.config."..module)
end

config("autopairs")
config("dressing")
config("general")
config("telescope")
config("treesitter")
