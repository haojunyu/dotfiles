# Neovim 常用快捷键

## 基础配置

- **Leader 键**: `<Space>` (空格键)
- **Local Leader 键**: `,` (逗号)

---

## 窗口分割

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<leader>sv` | 普通 | 垂直分割 | basic (内置) |
| `<leader>sh` | 普通 | 水平分割 | basic (内置) |
| `<leader>sc` | 普通 | 关闭分割 | basic (内置) |
| `<leader>wh` | 普通 | 切换到左侧窗口 | basic (内置) |
| `<leader>wj` | 普通 | 切换到下方窗口 | basic (内置) |
| `<leader>wk` | 普通 | 切换到上方窗口 | basic (内置) |
| `<leader>wl` | 普通 | 切换到右侧窗口 | basic (内置) |

---

## 缓冲区管理

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<leader>bp` | 普通 | 上一个缓冲区 | bufferline |
| `<leader>bn` | 普通 | 下一个缓冲区 | bufferline |
| `<leader>bb` | 普通 | 快速选择缓冲区 | bufferline |
| `<leader>bw` | 普通 | 关闭当前缓冲区 | snacks |
| `<leader>bW` | 普通 | 关闭其他所有缓冲区 | snacks |
| `<leader>bd` | 普通 | 关闭左侧缓冲区 | bufferline |
| `<leader>bf` | 普通 | 关闭右侧缓冲区 | bufferline |
| `<leader>bm` | 普通 | 前移缓冲区 | bufferline |
| `<leader>bi` | 普通 | 后移缓冲区 | bufferline |
| `<leader>bs` | 普通 | 按目录排序缓冲区 | bufferline |
| `<leader>be` | 普通 | 按扩展名排序缓冲区 | bufferline |
| `<leader>bt` | 普通 | 按相对目录排序缓冲区 | bufferline |
| `<leader>1` ~ `<leader>9` | 普通 | 跳转到缓冲区 1-9 | bufferline |

---

## 终端 (Floaterm)

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<leader>tn` | 普通/终端 | 新建终端 | floaterm |
| `<leader>tj` | 普通/终端 | 上一个终端 | floaterm |
| `<leader>tk` | 普通/终端 | 下一个终端 | floaterm |
| `<Esc>` | 普通/终端 | 切换终端显示 | floaterm |
| `<leader>tw` | 普通/终端 | 关闭终端 | floaterm |

---

## 搜索与高亮(当前buffer中)

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<leader>l` | 普通 | 清除搜索高亮 | basic (内置) |
| `n` | 普通 | 下一个搜索结果 (带高亮镜头) | hlslens |
| `N` | 普通 | 上一个搜索结果 (带高亮镜头) | hlslens |
| `*` | 普通 | 向前搜索当前词 (带高亮镜头) | hlslens |
| `#` | 普通 | 向后搜索当前词 (带高亮镜头) | hlslens |
| `g*` | 普通 | 向前全局搜索当前词(模糊匹配 ask -> piAsk) | hlslens |
| `g#` | 普通 | 向后全局搜索当前词(模糊匹配) | hlslens |

---

## AI / Claude Code

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<leader>ac` | 普通 | 切换 Claude | claudecode |
| `<leader>af` | 普通 | 聚焦 Claude | claudecode |
| `<leader>ar` | 普通 | 恢复会话 | claudecode |
| `<leader>aC` | 普通 | 继续对话 | claudecode |
| `<leader>aD` | 普通 | 新会话 (跳过权限检查) | claudecode |
| `<leader>am` | 普通 | 选择模型 | claudecode |
| `<leader>ab` | 普通 | 添加当前缓冲区 | claudecode |
| `<leader>as` | 可视 | 发送给 Claude | claudecode |
| `<leader>aa` | 普通 | 接受更改 | claudecode |
| `<leader>ad` | 普通 | 拒绝更改 | claudecode |

---

---


## 文件与搜索 (Finder)

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<leader>ff` | 普通 | 查找文件 | fff |
| `<leader>fF` | 普通 | 查找所有文件 (包括隐藏) | fff |
| `<leader>fg` | 普通 | 实时搜索 (grep) | fff |
| `<leader>/` | 普通 | 实时搜索 (grep) | fff |
| `<leader>*` | 普通 | 搜索光标下单词 | fff |
| `<leader>fz` | 普通 | 模糊搜索 | fff |
| `<leader>fG` | 普通 | 全局搜索 (含隐藏/忽略文件) | snacks |
| `<leader>fb` | 普通 | 查找缓冲区 | snacks |
| `<leader>fr` | 普通 | 最近打开的文件 | snacks |
| `<leader>ss` | 普通 | 文档符号 | snacks |
| `<leader>sS` | 普通 | 工作区符号 | snacks |
| `<leader>sd` | 普通 | 当前缓冲区诊断 | snacks |
| `<leader>sD` | 普通 | 工作区诊断 | snacks |
| `<leader>tt` | 普通 | 所有选择器 | snacks |

---

## LSP (语言服务器)

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<leader>rn` | 普通 | 重命名符号 | lsp-ui |
| `<leader>ca` | 普通 | 代码操作 | lsp-ui |
| `K` | 普通 | 悬停信息 / 查看折叠 | lsp-ui / ufo |
| `<leader>gd` | 普通 | 转到定义 | lsp-ui |
| `<leader>gD` | 普通 | 转到声明 | lsp-ui |
| `<leader>gi` | 普通 | 转到实现 | lsp-ui |
| `<leader>gr` | 普通 | 查找引用 | lsp-ui |
| `<leader>gy` | 普通 | 转到类型定义 | lsp-ui |
| `<leader>gk` | 普通 | 上一个诊断信息 | lsp-ui |
| `<leader>gj` | 普通 | 下一个诊断信息 | lsp-ui |
| `<leader>gh` | 普通 | 调用层次结构 (调用者) | lsp-ui |
| `<leader>gl` | 普通 | 调用层次结构 (被调用者) | lsp-ui |

---

## 调试 (DAP)

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<leader>db` | 普通 | 切换断点 | dap |
| `<leader>dB` | 普通 | 条件断点 | dap |
| `<leader>dl` | 普通 | 日志点 | dap |
| `<leader>dc` | 普通 | 继续执行 | dap |
| `<leader>dn` | 普通 | 新调试会话 | dap |
| `<leader>dp` | 普通 | 暂停 | dap |
| `<leader>dt` | 普通 | 终止 | dap |
| `<leader>dr` | 普通 | 重启 | dap |
| `<leader>dj` | 普通 | 单步跳过 | dap |
| `<leader>di` | 普通 | 单步进入 | dap |
| `<leader>do` | 普通 | 单步退出 | dap |
| `<leader>dO` | 普通 | 单步回退 | dap |
| `<leader>dR` | 普通 | 切换 REPL | dap |
| `<leader>du` | 普通 | 切换 DAP UI | dap / nvim-dap-ui |
| `<leader>de` | 普通/可视 | 计算表达式 | dap / nvim-dap-ui |
| `<leader>dC` | 普通 | 运行到光标处 | dap |
| `<leader>dg` | 普通 | 跳转到行 (不执行) | dap |
| `<leader>dw` | 普通 | 调试组件 | dap / nvim-dap-ui |

---

## Git

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<leader>ng` | 普通 | 打开 Neogit | neogit |

---

## GitHub (Octo)

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<leader>oi` | 普通 | 列出 Issues | octo |
| `<leader>op` | 普通 | 列出 PRs | octo |
| `<leader>oP` | 普通 | 当前分支的 PR | octo |
| `<leader>oc` | 普通 | PR CI 检查 | octo |
| `<leader>or` | 普通 | 开始 PR 审查 | octo |
| `<leader>oR` | 普通 | 继续 PR 审查 | octo |
| `<leader>os` | 普通 | 搜索 GitHub | octo |

---

## 代码格式化

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<leader>f` | 普通 | 格式化代码 | conform |

---

## 代码拆分/合并

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<leader>m` | 普通 | 切换拆分/合并 | treesj |

---

## 文件浏览器

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<leader>e` | 普通 | 切换文件浏览器 | nvim-tree |

---

## 大纲视图

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<leader>uo` | 普通 | 切换大纲视图 | outline |

---

## 折叠 (UFO)

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `zR` | 普通 | 展开所有折叠 | ufo |
| `zM` | 普通 | 关闭所有折叠 | ufo |
| `zr` | 普通 | 展开折叠 (排除指定类型) | ufo |
| `zm` | 普通 | 关闭折叠 (指定类型) | ufo |
| `zK` | 普通 | 预览光标下折叠内容 | ufo |

---

## 快速跳转 (Flash)

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `s` | 普通/可视 | Flash 跳转 | flash |
| `S` | 普通/可视 | Treesitter 跳转 | flash |
| `r` | 操作符 | 远程 Flash | flash |
| `R` | 操作符/可视 | Treesitter 搜索 | flash |
| `<C-s>` | 命令行 | 切换 Flash 搜索 | flash |

---

## 搜索替换 (Grug-FAR)

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<leader>gfg` | 普通 | 全局搜索 | grug-far |
| `<leader>gfr` | 普通/可视 | 搜索并替换 | grug-far |
| `<leader>gff` | 普通 | 当前文件搜索替换 | grug-far |
| `<leader>gfw` | 普通 | 搜索光标下单词 | grug-far |
| `<leader>gfg` | 可视 | 选中区域搜索 | grug-far |
| `<leader>gfi` | 普通/可视 | 在选中区域内搜索 | grug-far |
| `<leader>gfs` | 普通 | 当前搜索带入替换 | grug-far |
| `<leader>gft` | 普通 | 切换替换面板 | grug-far |

---

## 通知

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<leader>sn` | 普通 | 通知历史 | snacks |

---

## Quickfix

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `>` | Quickfix | 展开上下文 | quicker |
| `<` | Quickfix | 收起上下文 | quicker |

---

## URL 打开

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `gx` | 普通/可视 | 打开光标下 URL | gx (内置扩展) |

---

## 快捷键帮助

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<leader>?` | 普通 | 查看当前缓冲区快捷键 | which-key |

---

## Treesitter 导航

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<leader>[c` | 普通 | 跳到上一个上下文 | nvim-treesitter-context |
| `<leader>]m` | 普通/可视/操作符 | 跳到下一个函数结尾 | nvim-treesitter |
| `<leader>[m` | 普通/可视/操作符 | 跳到上一个函数开头 | nvim-treesitter |

---

> **提示**: 使用 `<leader>?` 可随时查看当前上下文中所有可用的快捷键。
