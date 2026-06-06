# Neovim 插件文档

> 基于 lazy.nvim 管理，配置文件位于 `lua/plugins/` 目录下。

## 目录

- [核心框架](#核心框架)
- [代码编辑](#代码编辑)
- [LSP & 补全](#lsp--补全)
- [格式化 & Lint](#格式化--lint)
- [AI 助手](#ai-助手)
- [调试](#调试)
- [搜索 & 跳转](#搜索--跳转)
- [文件管理](#文件管理)
- [Git 集成](#git-集成)
- [UI & 主题](#ui--主题)
- [终端 & 浮窗](#终端--浮窗)
- [其他工具](#其他工具)
- [已停用插件](#已停用插件)

---

## 核心框架

| 插件 | 文件 | 说明 |
|------|------|------|
| [folke/lazy.nvim](https://github.com/folke/lazy.nvim) | `plugin.lua` | 插件管理器。负责加载、安装、懒加载所有插件。配置了插件缓存、RTP 重置、内置插件禁用列表等性能优化选项。 |

## 代码编辑

| 插件 | 文件 | 说明 |
|------|------|------|
| [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | `treesitter.lua` | 语法分析核心。安装 50+ 语言的 grammar，提供语法高亮、代码折叠、文本对象等能力。`lazy = false` 确保启动即加载。 |
| [nvim-treesitter/nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context) | `treesitter.lua` | 顶部浮动显示当前上下文（函数名/类名等），`multiline_threshold = 5`，底部有灰色下划线分隔。 |
| [nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) | `treesitter.lua` | 基于语法结构的文本对象。支持按函数边界跳转（`<leader>]m` / `<leader>[m`）。 |
| [windwp/nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) | `treesitter.lua` | 自动补全/重命名 HTML/XML/JSX 标签。 |
| [folke/ts-comments.nvim](https://github.com/folke/ts-comments.nvim) | `ts-comments.lua` | 智能注释插件。根据文件类型自动选择注释语法，支持 `gcc`/`gc` 等注释操作。 |
| [kylechui/nvim-surround](https://github.com/kylechui/nvim-surround) | `surround.lua` | 括号/引号管理。支持 `ys` 添加、`ds` 删除、`cs` 替换包围符（如 `"` → `'` → `()`）。 |
| [Wansmer/treesj](https://github.com/Wansmer/treesj) | `treesj.lua` | 代码展开/合并。基于 Treesitter 将多行代码合并为单行或反向展开，快捷键 `<leader>m`。 |
| [saghen/blink.pairs](https://github.com/saghen/blink.pairs) | `blink-pairs.lua` | 自动括号配对。输入 `(` 自动补 `)`，支持智能跳过。 |
| [max397574/better-escape.nvim](https://github.com/max397574/better-escape.nvim) | `better-escape.lua` | 快速 ESC。通过 `jk`/`jj` 快速退出 Insert 模式，替代连续按两次 ESC。 |
| [HiPhish/rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim) | `rainbow-delimiters.lua` | 彩虹括号。基于 Treesitter 为嵌套括号/分隔符着色。使用 global 策略（默认）和 local 策略（Lua 文件），自定义 7 色高亮（Solarized 风格配色），Lua 文件使用 rainbow-blocks 查询。 |

## LSP & 补全

| 插件 | 文件 | 说明 |
|------|------|------|
| [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | `lsp-keymap.lua` | LSP 客户端配置。集成 Mason + mason-lspconfig 自动安装 15 个 LSP 服务器（gopls、basedpyright、vtsls、lua_ls 等）。注册了所有 LSP 原生快捷键（`<leader>gd` 跳转定义、`<leader>rn` 重命名、`<leader>ca` 代码操作等）。包含 InsertEnter 自动签名帮助 + inlay hints 启用。 |
| [mason-org/mason.nvim](https://github.com/mason-org/mason.nvim) | `lsp-keymap.lua` | 外部工具包管理器。自动安装 17 个 CLI 工具（格式化器、lint 工具、调试器等）。 |
| [mason-org/mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim) | `lsp-keymap.lua` | Mason 与 LSP 的桥接。自动将 Mason 安装的 LSP 服务器注册到 nvim-lspconfig。 |
| [saghen/blink.cmp](https://github.com/saghen/blink.cmp) | `blink-cmp.lua` | 自动补全引擎。支持 LSP、LazyDev、路径、代码片段、buffer 补全。集成了 Copilot suggestion（Tab 接受）、snippet 导航、文档预览。`score_offset` 控制补全排序优先级。 |
| [folke/lazydev.nvim](https://github.com/folke/lazydev.nvim) | `lazydev.lua` | Lua 语言 LSP 辅助。为 Neovim Lua 开发提供类型定义，检测 `vim.uv` 时加载 luvit 类型。集成 blink.cmp 作为补全源。 |
| [jinzhongjia/LspUI.nvim](https://github.com/jinzhongjia/LspUI.nvim) | `lspui.lua` | LSP UI 增强。集成 signature help、inlay hints、rename、code action、hover、definition/references/type definition 等 LSP 功能。`K` 键与 ufo 折叠 peek 集成（未折叠时显示 LSP hover）。dev 模式从本地 `~/coder` 目录加载。 |

## 格式化 & Lint

| 插件 | 文件 | 说明 |
|------|------|------|
| [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim) | `conform.lua` | 代码格式化。按文件类型配置格式化器（prettierd、clang_format、stylua、goimports-reviser 等）。`<leader>f` 触发异步格式化，优先使用 LSP 格式化，fallback 到外部工具。 |
| [mfussenegger/nvim-lint](https://github.com/mfussenegger/nvim-lint) | `lint.lua` | 静态 lint。在 `BufWritePost`/`BufReadPost`/`InsertLeave` 时触发，支持 shellcheck（bash）、hadolint（Dockerfile）、actionlint（GitHub Actions YAML）。 |

## AI 助手

| 插件 | 文件 | 说明 |
|------|------|------|
| [zbirenbaum/copilot.lua](https://github.com/zbirenbaum/copilot.lua) | `copilot.lua` | GitHub Copilot 代码建议。自动触发，针对 20+ 种文件类型启用（Go、Lua、TS、Python、C/C++ 等），默认对 `*` 禁用（白名单模式）。 |
| [coder/claudecode.nvim](https://github.com/coder/claudecode.nvim) | `claudecode.lua` | Claude Code 终端集成。右侧 35% 宽度分屏显示 Claude 终端，支持选择跟踪、diff 管理、会话恢复（`<leader>ac` 切换、`<leader>ar` 恢复、`<leader>as` 发送选中文本）。 |
| [aldoborrero/pi-agent.nvim](https://github.com/aldoborrero/pi-agent.nvim) | `pi.lua` | Pi Agent AI 终端集成。右侧分屏运行 `pi` CLI，支持自动文件刷新、Git 根目录工作、多实例（按 git root）。`<leader>ap` toggle 终端，`<leader>apc` continue 对话，`<leader>apv` verbose 模式。 |
| [jinzhongjia/ai-gitcommit.nvim](https://github.com/jinzhongjia/ai-gitcommit.nvim) | `ai-gitcommit.lua` | AI 生成 Git 提交信息。支持中文/英文双语生成，dev 模式从本地 `~/coder` 目录加载。 |

## 调试

| 插件 | 文件 | 说明 |
|------|------|------|
| [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap) | `dap.lua` | 调试适配器协议（DAP）核心。提供断点管理（普通/条件/日志点）、调试控制（continue/step/terminate）、REPL、表达式求值等完整调试能力。 |
| [rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) | `dap.lua` | DAP 调试界面。左侧面板显示 scopes/breakpoints/stacks/watches，底部显示 REPL/控制台。调试启动/终止时自动打开/关闭。 |
| [theHamsta/nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text) | `dap.lua` | DAP 内联变量显示。调试暂停时在代码行尾显示变量当前值，支持高亮变化变量。 |

## 搜索 & 跳转

| 插件 | 文件 | 说明 |
|------|------|------|
| [dmtrKovalenko/fff.nvim](https://github.com/dmtrKovalenko/fff.nvim) | `fff.lua` | 文件查找 + 内容搜索。支持 plain/regex/fuzzy 三种搜索模式、frecency 排序、查询历史、右侧预览。`<leader>ff` 查找文件，`<leader>fg` 实时 grep，`<leader>/` 快速搜索。 |
| [folke/flash.nvim](https://github.com/folke/flash.nvim) | `flash.lua` | 增强跳转。`s` 触发标签式跳转，支持 rainbow 标签、Treesitter 语义跳转、远程跳转。`f/F/t/T` 显示跳转标签。 |
| [kevinhwang91/nvim-hlslens](https://github.com/kevinhwang91/nvim-hlslens) | `hlslens.lua` | 搜索结果高亮增强。搜索后高亮所有匹配项，支持 `n/N`/`*`/`#` 等操作符的 lens 效果。 |
| [nacro90/numb.nvim](https://github.com/nacro90/numb.nvim) | `numb.lua` | 命令行预览。输入 `:123` 跳转行号时，实时预览目标行内容，隐藏相对行号减少干扰。 |
| [folke/snacks.nvim](https://github.com/folke/snacks.nvim) — Picker | `snacks.lua` | snacks 内置文件选择器。提供 buffers/recent/grep/diagnostics 等多维度搜索，排除 Go 生成文件（`.gen.go`、`.pb.go` 等）。 |

## 文件管理

| 插件 | 文件 | 说明 |
|------|------|------|
| [nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | `file-explorer.lua` | 文件浏览器。左侧树形结构显示项目文件，自适应大小、同步 cwd、自动过滤 `.git`/`node_modules`。支持 live filter 实时过滤。 |
| [folke/snacks.nvim](https://github.com/folke/snacks.nvim) — Explorer | `snacks.lua` | snacks 内置文件浏览模块（当前 `enabled = false`，使用 nvim-tree 替代）。 |

## Git 集成

| 插件 | 文件 | 说明 |
|------|------|------|
| [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | `gitsigns.lua` | Git 行内标注。在 signcolumn 显示增删改标记，当前行 blame 信息（显示作者/时间）。 |
| [NeogitOrg/neogit](https://github.com/NeogitOrg/neogit) | `neogit.lua` | Magit 风格的 Git 操作界面。提供完整的 Git GUI（提交、rebase、stash、分支管理），tab 方式打开，集成 codediff 查看差异。 |
| [pwntester/octo.nvim](https://github.com/pwntester/octo.nvim) | `octo.lua` | GitHub PR/Issue 管理。在 nvim 中浏览/创建/评论 PR 和 Issue，支持 PR review 流程。使用 snacks 作为选择器。 |
| [esmuellert/codediff.nvim](https://github.com/esmuellert/codediff.nvim) | `codediff.lua` | 差异查看器。树形浏览文件变更，支持 diff 对比。与 Neogit 集成使用。 |
| [folke/snacks.nvim](https://github.com/folke/snacks.nvim) — Git | `snacks.lua` | snacks 内置 Git 浏览、diff 查看、branch 切换等功能。 |
| [chrishrb/gx.nvim](https://github.com/chrishrb/gx.nvim) | `gx.lua` | URL 浏览器。`gx` 打开光标下的 URL，自动识别 GitHub/GitLab 等托管平台并跳转到对应网页。替代 netrw 的 `gx`。 |

## UI & 主题

| 插件 | 文件 | 说明 |
|------|------|------|
| [Mofiqul/vscode.nvim](https://github.com/Mofiqul/vscode.nvim) | `theme.lua` | VS Code 深色主题。支持 italic comments、inlay hints 斜体、链接下划线。`priority = 1000` 确保最先加载。 |
| [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | `bufferline.lua` | 顶部 buffer 标签栏。显示文件名、修改状态、LSP 诊断图标。支持排序（按目录/扩展名）、数字快捷键跳转、Snacks 集成关闭 buffer。 |
| [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | `lualine.lua` | 底部状态栏。显示模式、cwd、分支、文件名、Copilot 状态、位置。Winbar 显示文件路径 + navic 面包屑。DAP/CodeCompanion/Neogit 等特殊窗口有定制扩展。 |
| [SmiteshP/nvim-navic](https://github.com/SmiteshP/nvim-navic) | `lualine.lua` | LSP 面包屑导航。依赖 nvim-lspconfig，自动 attach 到支持 documentSymbol 的 LSP。在 lualine winbar 中显示当前位置（`>` 分隔）。 |
| [j-hui/fidget.nvim](https://github.com/j-hui/fidget.nvim) | `fidget.lua` | LSP 进度指示器。右下角浮动显示 LSP 服务器启动/索引进度。集成 CodeCompanion 进度显示（Thinking... → Done）。 |
| [MeanderingProgrammer/render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | `render-markdown.lua` | Markdown 渲染。将 markdown 语法渲染为美化效果（标题、checkbox、callouts），支持 anti-conceal（光标所在行显示原始语法）。为 codecompanion/opencode_output buffer 定制样式。 |
| [OXY2DEV/helpview.nvim](https://github.com/OXY2DEV/helpview.nvim) | `helpview.lua` | Vim 帮助文件渲染。美化 `:help` 页面的显示效果。 |
| [catgoose/nvim-colorizer.lua](https://github.com/catgoose/nvim-colorizer.lua) | `colorizer.lua` | 颜色预览。在 HTML/CSS 文件中实时显示颜色色块，支持 hex、rgb、hsl、oklch、Tailwind 颜色名等格式。 |
| [tiagovla/scope.nvim](https://github.com/tiagovla/scope.nvim) | `scope.lua` | 代码作用域高亮。为当前光标所在的代码块（函数/条件分支等）添加背景高亮，增强代码结构可见性。 |
| [folke/which-key.nvim](https://github.com/folke/which-key.nvim) | `which-key.lua` | 快捷键提示。Helix 风格预设，`<leader>?` 显示当前 buffer 的局部快捷键列表。 |

## 终端 & 浮窗

| 插件 | 文件 | 说明 |
|------|------|------|
| [voldikss/vim-floaterm](https://github.com/voldikss/vim-floaterm) | `floaterm.lua` | 浮动终端。85%×80% 大小的浮动终端窗口，支持多实例切换（`<leader>fj`/`<leader>fk`）、新建/切换/关闭。 |
| [folke/snacks.nvim](https://github.com/folke/snacks.nvim) — Terminal | `snacks.lua` | snacks 内置浮动终端。浮动式 80%×80% 大小，可作为 vim-floaterm 的替代方案。 |

## 其他工具

| 插件 | 文件 | 说明 |
|------|------|------|
| [folke/snacks.nvim](https://github.com/folke/snacks.nvim) | `snacks.lua` | **瑞士军刀插件**。启用以下模块：`bigfile`（大文件优化）、`bufdelete`（安全删除 buffer）、`dim`（非活动窗口变暗）、`git`/`gitbrowse`（Git 浏览）、`input`（输入框）、`notifier`（通知系统）、`picker`（文件选择器）、`quickfile`（快速打开文件）、`scope`（代码作用域）、`scratch`（草稿笔记）、`statuscolumn`（状态列）、`terminal`（终端）、`toggle`（设置切换）、`words`（相同单词高亮）、`outline`（符号大纲）、`navic`（面包屑导航）。 |
| [kevinhwang91/nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) | `ufo.lua` | 高级代码折叠。折叠方案优先级：LSP → indent。自定义折叠标签显示折叠行数，支持 `zK` peek 折叠内容。与 `K` 键集成（优先 peek 折叠，再显示 LSP hover）。 |
| [stevearc/quicker.nvim](https://github.com/stevearc/quicker.nvim) | `quicker.lua` | Quickfix 增强。在 quickfix 窗口中 `>` 展开上下文（前后 2 行），`<` 折叠。 |
| [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | `todo-comments.lua` | TODO 注释高亮。高亮 `TODO`/`FIXME`/`HACK`/`BUG`/`WARN` 等关键字，可通过 `:TodoTelescope` 或 snacks picker 快速跳转。 |
| [MagicDuck/grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim) | `grug-far.lua` | 搜索与替换。浮窗式全局搜索/替换，支持当前文件、选中区域、上一次搜索结果。`<leader>gft` 切换面板，`<leader>gfw` 搜索光标下单词。 |
| [hat0uma/csvview.nvim](https://github.com/hat0uma/csvview.nvim) | `csvview.lua` | CSV 查看器。将 CSV 文件渲染为对齐的表格视图，方便查看结构化数据。 |
| [dmtrKovalenko/fff.nvim](https://github.com/dmtrKovalenko/fff.nvim) | `fff.lua` | 模糊搜索器。提供文件查找和实时 grep，支持 frecency 排序、查询历史、预览。 |

## 已停用插件

| 插件 | 文件 | 状态 | 说明 |
|------|------|------|------|
| [olimorris/codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim) | `codecompanion.lua` | `enabled = false` | AI 聊天助手。曾集成历史、MCP Hub、VectorCode 向量检索等扩展，已保留完整配置以备将来使用。 |
| [HakonHarnes/img-clip.nvim](https://github.com/HakonHarnes/img-clip.nvim) | `codecompanion.lua` | 跟随 CodeCompanion | 图片粘贴支持。随 CodeCompanion 一起停用。 |
| [sudo-tee/opencode.nvim](https://github.com/sudo-tee/opencode.nvim) | `opencode.lua` | `enabled = false` | OpenCode AI 终端集成。dev 模式从本地加载，保留完整 UI/上下文配置。 |

---

## 插件统计

- **活跃插件**：46 个（分布在 48 个插件文件中，含 1 个停用）
- **已停用**：3 个（CodeCompanion、img-clip、opencode）
- **核心依赖**：lazy.nvim（插件管理）、plenary.nvim（通用库）
- **自研/本地插件**：ai-gitcommit.nvim、LspUI.nvim（dev 模式）、opencode.nvim（dev 模式）

## 快捷键图例

| 前缀 | 用途 |
|------|------|
| `<leader>f` | 查找（Find）：文件、grep、buffer、recent |
| `<leader>s` | 符号（Symbol）：LSP 符号、诊断 |
| `<leader>g` | 搜索替换（Grug-far） |
| `<leader>d` | 调试（Debug）：断点、步进、REPL |
| `<leader>a` | AI：Claude Code（`c/r/s`）、Pi Agent（`p`/`pc`/`pv`） |
| `<leader>n` | Git（Neogit）、通知 |
| `<leader>o` | GitHub（Octo）：PR、Issue |
| `<leader>b` | Buffer：切换、关闭、排序 |
| `<leader>w` | 窗口：切换分屏 |
| `<leader>t` | 标签页 |
