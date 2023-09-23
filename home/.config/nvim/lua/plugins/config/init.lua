local function config(module)
    return require("plugins.config."..module)
end

config("general")
config("telescope")
config("treesitter")
config("dressing")