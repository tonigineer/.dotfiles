local function config(module)
    return require("options."..module)
end

config("colors")
config("theme")