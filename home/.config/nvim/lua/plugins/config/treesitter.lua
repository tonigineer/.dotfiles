---@diagnostic disable: missing-fields
-- require("nvim-dap-repl-highlights").setup()

require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "c",
        "cpp",
        "lua",
        "vim",
        "rust",
        "python",
        "cmake",
        "css",
        "dockerfile",
        "git_config",
        "gitignore",
        "http",
        "luadoc",
        "markdown",
        "markdown_inline",
        "regex",
        "rust",
        "yaml",
        "json",

        "toml",

        "bash"
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true
    },
    indent = {
        enable = true
    },
    autotag = {
        enable = true
    },
    sync_install = true
}
