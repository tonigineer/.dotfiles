require("lazy").setup {
    -- plugins
    {
    -- ======================
    --       ESSENTIALS      
    -- ======================
        
        {--[[ Fuzzy finder ]]    "nvim-telescope/telescope.nvim",
            dependencies = {
                --[[ Plenary: Functions ]]    "nvim-lua/plenary.nvim",
            }
        },
        --[[ Treesitter ]]    {"nvim-treesitter/nvim-treesitter",
            build = function () vim.cmd(":TSUpdate") end
        },
        --[[ Lsp UI ]]    "stevearc/dressing.nvim",

    -- ======================
    --         VANITY        
    -- ======================
        --[[ Rose Pine: theme ]]    "rose-pine/neovim",
    },
    -- options
    {
    }
}

require("plugins.config")