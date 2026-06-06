return
--- @type LazySpec
{
    {
        "catppuccin/nvim",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- 默认风格，可选: latte, frappe, macchiato, mocha
                transparent_background = false, -- 是否开启透明背景
                term_colors = true, -- 联动终端颜色
                integrations = {
                    cmp = true,         -- 自动补全
                    gitsigns = true,    -- Git 状态
                    nvimtree = true,    -- 文件树
                    treesitter = true,  -- 语法高亮
                    telescope = {
                        enabled = true,   -- 模糊搜索
                    },
                    mini = {
                        enabled = true,   -- mini 插件系列
                    },
                },
            })

            -- 激活主题
            vim.cmd.colorscheme "catppuccin"
        end,
    },
}
