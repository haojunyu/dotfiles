return
--- @type LazySpec
{
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "codecompanion", "opencode_output" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            -- 启用的文件类型（需与 ft 保持一致）
            file_types = { "markdown", "codecompanion", "opencode_output" },

            -- ===== 标题渲染 =====
            heading = {
                enabled = true,
                -- h1 ~ h6 的图标（替换 # 符号）
                icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
                -- 图标显示位置：overlay 覆盖 # 符号，inline 行内，right 右侧，eol 行尾
                position = "overlay",
                -- 背景色铺满整行
                width = "full",
            },

            -- ===== 代码块渲染 =====
            code = {
                enabled = true,
                -- 语言标签显示位置
                language = {
                    enabled = true,
                    position = "right",
                },
            },

            -- ===== 列表渲染 =====
            bullet = {
                enabled = true,
                -- 不同层级的列表使用不同图标（- / + / * 无序列表）
                icons = { "●", "○", "◆", "◇" },
                right_pad = 1,
            },

            -- ===== 分割线 =====
            dash = {
                enabled = true,
                icon = "─",
                width = "full",
            },

            -- ===== 引用块 =====
            quote = {
                enabled = true,
                icon = "▋",
            },

            -- ===== 表格美化 =====
            pipe_table = {
                enabled = true,
                cell = "padded",
                padding = 1,
            },

            -- ===== 链接渲染 =====
            link = {
                enabled = true,
            },

            -- 启用 anti-conceal：光标所在行显示原始 markdown 语法
            anti_conceal = {
                enabled = true,
                above = 0,
                below = 0,
                ignore = {
                    code_background = true,
                    sign = true,
                },
            },

            -- 启用 LSP completions 支持
            completions = {
                lsp = { enabled = true },
            },

            -- Checkbox 自定义样式
            checkbox = {
                unchecked = { icon = "✘ " },
                checked = { icon = "✔ " },
                custom = {
                    todo = { raw = "[-]", rendered = "◯ ", highlight = "RenderMarkdownTodo" },
                },
            },

            -- HTML 标签渲染（保留原有配置）
            html = {
                enabled = true,
                tag = {
                    buf = { icon = "󱔗 ", highlight = "CodeCompanionChatVariable" },
                    file = { icon = "󰈮 ", highlight = "CodeCompanionChatVariable" },
                    help = { icon = "󰱼 ", highlight = "CodeCompanionChatVariable" },
                    image = { icon = " ", highlight = "CodeCompanionChatVariable" },
                    symbols = { icon = " ", highlight = "CodeCompanionChatVariable" },

                    url = { icon = "󰖟 ", highlight = "CodeCompanionChatVariable" },
                    var = { icon = " ", highlight = "CodeCompanionChatVariable" },
                    tool = { icon = " ", highlight = "CodeCompanionChatTool" },
                    user = { icon = " ", highlight = "CodeCompanionChatTool" },
                    group = { icon = " ", highlight = "CodeCompanionChatToolGroup" },
                    memory = { icon = "󰍛 ", highlight = "CodeCompanionChatVariable" },
                    rules = { icon = "󰺾 ", highlight = "CodeCompanionChatVariable" },
                },
            },

            -- 针对特殊 buffer 类型的优化
            overrides = {
                buftype = {
                    nofile = {
                        render_modes = true,
                        sign = { enabled = false },
                        padding = { highlight = "NormalFloat" },
                    },
                },
            },
        },
    },
}
