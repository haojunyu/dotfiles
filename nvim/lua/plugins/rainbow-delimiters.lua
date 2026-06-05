return
--- @type LazySpec
{
    {
        "HiPhish/rainbow-delimiters.nvim",
        event = { "BufReadPost" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            -- 自定义 delimiter 颜色（适配 vscode 主题风格）
            vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#cb4b42" })
            vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#b58900" })
            vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#268bd2" })
            vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#cb7931" })
            vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#859900" })
            vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#6c71c4" })
            vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#2aa198" })

            ---@type rainbow.config
            local config = {
                strategy = {
                    [""] = require("rainbow-delimiters").strategy["global"],
                    vim = require("rainbow-delimiters").strategy["local"],
                },
                query = {
                    [""] = "rainbow-delimiters",
                    lua = "rainbow-blocks",
                },
                highlight = {
                    "RainbowDelimiterRed",
                    "RainbowDelimiterYellow",
                    "RainbowDelimiterBlue",
                    "RainbowDelimiterOrange",
                    "RainbowDelimiterGreen",
                    "RainbowDelimiterViolet",
                    "RainbowDelimiterCyan",
                },
            }
            require("rainbow-delimiters.setup").setup(config)
        end,
    },
}
