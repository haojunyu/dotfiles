# Neovim 常用快捷键

> TIPS:
> 为了保证ubuntu 中的快捷键（Ctrl-Super-Alt）和 mac 中的按键（Ctrl-Alt-Super）习惯一致，所有将ubuntu中的Super
> 和 Alt 键位互换，并且禁掉 ubuntu 中 Super 相关的快捷键
> ```bash
> ## Super（133）换左alt（64）,接近mac按键习惯 【option】
> sudo vim /usr/share/X11/xkb/keycodes/evdev
> <LWIN> = 64;
> <LALT> = 133;
> ## 取消单独按 Super 键展示活动总览的功能, 其他和 Super 相关的到系统->键盘->快捷键中取消
> gsettings set org.gnome.mutter overlay-key ''
> ## 查看活动展览功能快捷键
> gsettings list-recursively org.gnome.mutter | grep overlay
> ```


## 高频按键

> 使用 `Ctrl + 数字` 或其他组合键快速切换常用面板，在普通模式和终端模式下均可触发。

| 快捷键    | 模式      | 命令                            | 说明                                                 | 来源          |
| --------- | --------- | ------------------------------- | ---------------------------------------------------- | ------------- |
| `<C-1>`   | 普通/终端 | `:NvimTreeToggle`               | 切换文件浏览器 (NvimTree)                            | file-explorer |
| `<C-2>`   | 普通/终端 | `:ClaudeCode`                   | 切换 Claude Code                                     | claudecode    |
| `<C-3>`   | 普通/终端 | `Snacks.terminal` (bottom, 30%) | 切换底部终端 (30% 高度)                              | snacks        |
| `<C-4>`   | 普通/终端 | `Snacks.lazygit()`              | LazyGit (snacks 集成版，自动配色 + nvim-remote 编辑) | snacks        |
| `<C-\`>`  | 普通/终端 | `<C-w>w` / `<C-\><C-n><C-w>w`   | 切换窗口焦点                                         | basic (内置)  |
| `<C-Esc>` | 普通/终端 | `:FloatermToggle`               | 切换终端显示                                         | floaterm      |

---

## 基础配置

- **Leader 键**: `<Space>` (空格键)
- **Local Leader 键**: `,` (逗号)

---

## 窗口分割

| 快捷键       | 模式      | 命令                          | 说明           | 来源         |
| ------------ | --------- | ----------------------------- | -------------- | ------------ |
| `<leader>sv` | 普通      | `:vsplit`                     | 垂直分割       | basic (内置) |
| `<leader>sh` | 普通      | `:split`                      | 水平分割       | basic (内置) |
| `<leader>sc` | 普通      | `:close`                      | 关闭分割       | basic (内置) |
| `<leader>wh` | 普通      | `<C-w>h`                      | 切换到左侧窗口 | basic (内置) |
| `<leader>wj` | 普通      | `<C-w>j`                      | 切换到下方窗口 | basic (内置) |
| `<leader>wk` | 普通      | `<C-w>k`                      | 切换到上方窗口 | basic (内置) |
| `<leader>wl` | 普通      | `<C-w>l`                      | 切换到右侧窗口 | basic (内置) |
| `<C-\`>`     | 普通/终端 | `<C-w>w` / `<C-\><C-n><C-w>w` | 切换窗口焦点   | basic (内置) |

---

## 文件浏览器和大纲视图

| 快捷键       | 模式      | 命令              | 说明                      | 来源      |
| ------------ | --------- | ----------------- | ------------------------- | --------- |
| `<C-1>`      | 普通/终端 | `:NvimTreeToggle` | 切换文件浏览器 (NvimTree) | nvim-tree |
| `<leader>e`  | 普通      | `:NvimTreeToggle` | 切换文件浏览器            | nvim-tree |
| `<leader>uo` | 普通      | `:Outline`        | 切换大纲视图              | outline   |

---

---

## 缓冲区管理

| 快捷键                    | 模式 | 命令                                 | 说明                 | 来源       |
| ------------------------- | ---- | ------------------------------------ | -------------------- | ---------- |
| `<leader>bp`              | 普通 | `:BufferLineCyclePrev`               | 上一个缓冲区         | bufferline |
| `<leader>bn`              | 普通 | `:BufferLineCycleNext`               | 下一个缓冲区         | bufferline |
| `<leader>bb`              | 普通 | `:BufferLinePick`                    | 快速选择缓冲区       | bufferline |
| `<leader>bw`              | 普通 | `Snacks.bufdelete()`                 | 关闭当前缓冲区       | snacks     |
| `<leader>bW`              | 普通 | `Snacks.bufdelete.other()`           | 关闭其他所有缓冲区   | snacks     |
| `<leader>bd`              | 普通 | `:BufferLineCloseLeft`               | 关闭左侧缓冲区       | bufferline |
| `<leader>bf`              | 普通 | `:BufferLineCloseRight`              | 关闭右侧缓冲区       | bufferline |
| `<leader>bm`              | 普通 | `:BufferLineMovePrev`                | 前移缓冲区           | bufferline |
| `<leader>bi`              | 普通 | `:BufferLineMoveNext`                | 后移缓冲区           | bufferline |
| `<leader>bs`              | 普通 | `:BufferLineSortByDirectory`         | 按目录排序缓冲区     | bufferline |
| `<leader>be`              | 普通 | `:BufferLineSortByExtension`         | 按扩展名排序缓冲区   | bufferline |
| `<leader>bt`              | 普通 | `:BufferLineSortByRelativeDirectory` | 按相对目录排序缓冲区 | bufferline |
| `<leader>1` ~ `<leader>9` | 普通 | `:BufferLineGoToBuffer 1-9`          | 跳转到缓冲区 1-9     | bufferline |

---

## 终端

| 快捷键       | 模式      | 命令                            | 说明                    | 来源     |
| ------------ | --------- | ------------------------------- | ----------------------- | -------- |
| `<C-3>`      | 普通/终端 | `Snacks.terminal` (bottom, 30%) | 切换底部终端 (30% 高度) | snacks   |
| `<C-4>`      | 普通/终端 | `Snacks.lazygit()`              | LazyGit (snacks 集成版) | snacks   |
| `<leader>tn` | 普通/终端 | `:FloatermNew`                  | 新建终端                | floaterm |
| `<leader>tj` | 普通/终端 | `:FloatermPrev`                 | 上一个终端              | floaterm |
| `<leader>tk` | 普通/终端 | `:FloatermNext`                 | 下一个终端              | floaterm |
| `<C-Esc>`    | 普通/终端 | `:FloatermToggle`               | 切换终端显示            | floaterm |
| `<leader>tw` | 普通/终端 | `:FloatermKill`                 | 关闭终端                | floaterm |

---

## Git 和 GitHub (Octo)

| 快捷键       | 模式      | 命令                  | 说明                    | 来源   |
| ------------ | --------- | --------------------- | ----------------------- | ------ |
| `<C-4>`      | 普通/终端 | `Snacks.lazygit()`    | LazyGit (snacks 集成版) | snacks |
| `<leader>oi` | 普通      | `:Octo issue list`    | 列出 Issues             | octo   |
| `<leader>op` | 普通      | `:Octo pr list`       | 列出 PRs                | octo   |
| `<leader>oP` | 普通      | `:Octo pr`            | 当前分支的 PR           | octo   |
| `<leader>oc` | 普通      | `:Octo pr checks`     | PR CI 检查              | octo   |
| `<leader>or` | 普通      | `:Octo review start`  | 开始 PR 审查            | octo   |
| `<leader>oR` | 普通      | `:Octo review resume` | 继续 PR 审查            | octo   |
| `<leader>os` | 普通      | `:Octo search`        | 搜索 GitHub             | octo   |

---

## 搜索与高亮(当前buffer中)

| 快捷键      | 模式 | 命令                     | 说明                                      | 来源         |
| ----------- | ---- | ------------------------ | ----------------------------------------- | ------------ |
| `<leader>l` | 普通 | `:nohlsearch`            | 清除搜索高亮                              | basic (内置) |
| `n`         | 普通 | `n` + `hlslens.start()`  | 下一个搜索结果 (带高亮镜头)               | hlslens      |
| `N`         | 普通 | `N` + `hlslens.start()`  | 上一个搜索结果 (带高亮镜头)               | hlslens      |
| `*`         | 普通 | `*` + `hlslens.start()`  | 向前搜索当前词 (带高亮镜头)               | hlslens      |
| `#`         | 普通 | `#` + `hlslens.start()`  | 向后搜索当前词 (带高亮镜头)               | hlslens      |
| `g*`        | 普通 | `g*` + `hlslens.start()` | 向前全局搜索当前词(模糊匹配 ask -> piAsk) | hlslens      |
| `g#`        | 普通 | `g#` + `hlslens.start()` | 向后全局搜索当前词(模糊匹配)              | hlslens      |

---

## AI / Claude Code

| 快捷键       | 模式      | 命令                                         | 说明                  | 来源       |
| ------------ | --------- | -------------------------------------------- | --------------------- | ---------- |
| `<C-2>`      | 普通/终端 | `:ClaudeCode`                                | 切换 Claude           | claudecode |
| `<leader>ac` | 普通      | `:ClaudeCode`                                | 切换 Claude           | claudecode |
| `<leader>af` | 普通      | `:ClaudeCodeFocus`                           | 聚焦 Claude           | claudecode |
| `<leader>ar` | 普通      | `:ClaudeCode --resume`                       | 恢复会话              | claudecode |
| `<leader>aC` | 普通      | `:ClaudeCode --continue`                     | 继续对话              | claudecode |
| `<leader>aD` | 普通      | `:ClaudeCode --dangerously-skip-permissions` | 新会话 (跳过权限检查) | claudecode |
| `<leader>am` | 普通      | `:ClaudeCodeSelectModel`                     | 选择模型              | claudecode |
| `<leader>ab` | 普通      | `:ClaudeCodeAdd %`                           | 添加当前缓冲区        | claudecode |
| `<leader>as` | 可视      | `:ClaudeCodeSend`                            | 发送给 Claude         | claudecode |
| `<leader>aa` | 普通      | `:ClaudeCodeDiffAccept`                      | 接受更改              | claudecode |
| `<leader>ad` | 普通      | `:ClaudeCodeDiffDeny`                        | 拒绝更改              | claudecode |

---

---

---

## 文件与搜索 (Finder)

| 快捷键       | 模式 | 命令                                    | 说明                       | 来源   |
| ------------ | ---- | --------------------------------------- | -------------------------- | ------ |
| `<leader>ff` | 普通 | `fff.find_files()`                      | 查找文件                   | fff    |
| `<leader>fF` | 普通 | `fff.find_files({ignore={}})`           | 查找所有文件 (包括隐藏)    | fff    |
| `<leader>fg` | 普通 | `fff.live_grep()`                       | 实时搜索 (grep)            | fff    |
| `<leader>/`  | 普通 | `fff.live_grep()`                       | 实时搜索 (grep)            | fff    |
| `<leader>*`  | 普通 | `fff.live_grep({query=<cword>})`        | 搜索光标下单词             | fff    |
| `<leader>fz` | 普通 | `fff.live_grep({fuzzy+plain})`          | 模糊搜索                   | fff    |
| `<leader>fG` | 普通 | `Snacks.picker.grep` (hidden+ignored)   | 全局搜索 (含隐藏/忽略文件) | snacks |
| `<leader>fb` | 普通 | `Snacks.picker.buffers()`               | 查找缓冲区                 | snacks |
| `<leader>fr` | 普通 | `Snacks.picker.recent()`                | 最近打开的文件             | snacks |
| `<leader>ss` | 普通 | `Snacks.picker.lsp_symbols()`           | 文档符号                   | snacks |
| `<leader>sS` | 普通 | `Snacks.picker.lsp_workspace_symbols()` | 工作区符号                 | snacks |
| `<leader>sd` | 普通 | `Snacks.picker.diagnostics_buffer()`    | 当前缓冲区诊断             | snacks |
| `<leader>sD` | 普通 | `Snacks.picker.diagnostics()`           | 工作区诊断                 | snacks |
| `<leader>tt` | 普通 | `Snacks.picker.pickers()`               | 所有选择器                 | snacks |

---

## LSP (语言服务器)

| 快捷键       | 模式 | 命令                                                | 说明                    | 来源         |
| ------------ | ---- | --------------------------------------------------- | ----------------------- | ------------ |
| `<leader>rn` | 普通 | `:LspUI rename`                                     | 重命名符号              | lsp-ui       |
| `<leader>ca` | 普通 | `:LspUI code_action`                                | 代码操作                | lsp-ui       |
| `K`          | 普通 | `ufo.peekFoldedLinesUnderCursor()` / `:LspUI hover` | 悬停信息 / 查看折叠     | lsp-ui / ufo |
| `<leader>gd` | 普通 | `:LspUI definition`                                 | 转到定义                | lsp-ui       |
| `<leader>gD` | 普通 | `:LspUI declaration`                                | 转到声明                | lsp-ui       |
| `<leader>gi` | 普通 | `:LspUI implementation`                             | 转到实现                | lsp-ui       |
| `<leader>gr` | 普通 | `:LspUI reference`                                  | 查找引用                | lsp-ui       |
| `<leader>gy` | 普通 | `:LspUI type_definition`                            | 转到类型定义            | lsp-ui       |
| `<leader>gk` | 普通 | `:LspUI diagnostic prev`                            | 上一个诊断信息          | lsp-ui       |
| `<leader>gj` | 普通 | `:LspUI diagnostic next`                            | 下一个诊断信息          | lsp-ui       |
| `<leader>gh` | 普通 | `:LspUI call_hierarchy incoming`                    | 调用层次结构 (调用者)   | lsp-ui       |
| `<leader>gl` | 普通 | `:LspUI call_hierarchy outgoing`                    | 调用层次结构 (被调用者) | lsp-ui       |

---

## 调试 (DAP)

| 快捷键       | 模式      | 命令                                   | 说明              | 来源              |
| ------------ | --------- | -------------------------------------- | ----------------- | ----------------- |
| `<leader>db` | 普通      | `dap.toggle_breakpoint()`              | 切换断点          | dap               |
| `<leader>dB` | 普通      | `dap.set_breakpoint(input())`          | 条件断点          | dap               |
| `<leader>dl` | 普通      | `dap.set_breakpoint(logpoint=input())` | 日志点            | dap               |
| `<leader>dc` | 普通      | `dap.continue()`                       | 继续执行          | dap               |
| `<leader>dn` | 普通      | `dap.new()`                            | 新调试会话        | dap               |
| `<leader>dp` | 普通      | `dap.pause()`                          | 暂停              | dap               |
| `<leader>dt` | 普通      | `dap.terminate()`                      | 终止              | dap               |
| `<leader>dr` | 普通      | `dap.restart()`                        | 重启              | dap               |
| `<leader>dj` | 普通      | `dap.step_over()`                      | 单步跳过          | dap               |
| `<leader>di` | 普通      | `dap.step_into()`                      | 单步进入          | dap               |
| `<leader>do` | 普通      | `dap.step_out()`                       | 单步退出          | dap               |
| `<leader>dO` | 普通      | `dap.step_back()`                      | 单步回退          | dap               |
| `<leader>dR` | 普通      | `dap.repl.toggle()`                    | 切换 REPL         | dap               |
| `<leader>du` | 普通      | `dapui.toggle()`                       | 切换 DAP UI       | dap / nvim-dap-ui |
| `<leader>de` | 普通/可视 | `dapui.eval()`                         | 计算表达式        | dap / nvim-dap-ui |
| `<leader>dC` | 普通      | `dap.run_to_cursor()`                  | 运行到光标处      | dap               |
| `<leader>dg` | 普通      | `dap.goto_()`                          | 跳转到行 (不执行) | dap               |
| `<leader>dw` | 普通      | `dap.ui.widgets.hover()`               | 调试组件          | dap / nvim-dap-ui |

---

## 代码格式化

| 快捷键      | 模式 | 命令                           | 说明       | 来源    |
| ----------- | ---- | ------------------------------ | ---------- | ------- |
| `<leader>f` | 普通 | `conform.format({async=true})` | 格式化代码 | conform |

---

## 代码拆分/合并

| 快捷键      | 模式 | 命令              | 说明          | 来源   |
| ----------- | ---- | ----------------- | ------------- | ------ |
| `<leader>m` | 普通 | `treesj.toggle()` | 切换拆分/合并 | treesj |

---

## 折叠 (UFO)

| 快捷键 | 模式 | 命令                                                       | 说明                    | 来源 |
| ------ | ---- | ---------------------------------------------------------- | ----------------------- | ---- |
| `zR`   | 普通 | `ufo.openAllFolds()`                                       | 展开所有折叠            | ufo  |
| `zM`   | 普通 | `ufo.closeAllFolds()`                                      | 关闭所有折叠            | ufo  |
| `zr`   | 普通 | `ufo.openFoldsExceptKinds()`                               | 展开折叠 (排除指定类型) | ufo  |
| `zm`   | 普通 | `ufo.closeFoldsWith()`                                     | 关闭折叠 (指定类型)     | ufo  |
| `zK`   | 普通 | `ufo.peekFoldedLinesUnderCursor()` / `vim.lsp.buf.hover()` | 预览光标下折叠内容      | ufo  |

---

## 快速跳转 (Flash)

| 快捷键  | 模式        | 命令                        | 说明            | 来源  |
| ------- | ----------- | --------------------------- | --------------- | ----- |
| `s`     | 普通/可视   | `flash.jump()`              | Flash 跳转      | flash |
| `S`     | 普通/可视   | `flash.treesitter()`        | Treesitter 跳转 | flash |
| `r`     | 操作符      | `flash.remote()`            | 远程 Flash      | flash |
| `R`     | 操作符/可视 | `flash.treesitter_search()` | Treesitter 搜索 | flash |
| `<C-s>` | 命令行      | `flash.toggle()`            | 切换 Flash 搜索 | flash |

---

## 搜索替换 (Grug-FAR)

| 快捷键        | 模式      | 命令                                  | 说明             | 来源     |
| ------------- | --------- | ------------------------------------- | ---------------- | -------- |
| `<leader>gfg` | 普通      | `grug-far.toggle_instance("search")`  | 全局搜索         | grug-far |
| `<leader>gfr` | 普通/可视 | `grug-far.open({transient=true})`     | 搜索并替换       | grug-far |
| `<leader>gff` | 普通      | `grug-far.open({paths=%})`            | 当前文件搜索替换 | grug-far |
| `<leader>gfw` | 普通      | `grug-far.open({search=<cword>})`     | 搜索光标下单词   | grug-far |
| `<leader>gfg` | 可视      | `grug-far.with_visual_selection()`    | 选中区域搜索     | grug-far |
| `<leader>gfi` | 普通/可视 | `grug-far.open(operate-within-range)` | 在选中区域内搜索 | grug-far |
| `<leader>gfs` | 普通      | Lua 函数 (当前搜索带入替换)           | 当前搜索带入替换 | grug-far |
| `<leader>gft` | 普通      | `grug-far.toggle_instance("far")`     | 切换替换面板     | grug-far |

---

## 通知

| 快捷键       | 模式 | 命令                             | 说明     | 来源   |
| ------------ | ---- | -------------------------------- | -------- | ------ |
| `<leader>sn` | 普通 | `Snacks.notifier.show_history()` | 通知历史 | snacks |

---

## Quickfix

| 快捷键 | 模式     | 命令                                 | 说明       | 来源    |
| ------ | -------- | ------------------------------------ | ---------- | ------- |
| `>`    | Quickfix | `quicker.expand({before=2,after=2})` | 展开上下文 | quicker |
| `<`    | Quickfix | `quicker.collapse()`                 | 收起上下文 | quicker |

---

## URL 打开

| 快捷键 | 模式      | 命令      | 说明           | 来源          |
| ------ | --------- | --------- | -------------- | ------------- |
| `gx`   | 普通/可视 | `:Browse` | 打开光标下 URL | gx (内置扩展) |

---

## 快捷键帮助

| 快捷键      | 模式 | 命令                             | 说明                 | 来源      |
| ----------- | ---- | -------------------------------- | -------------------- | --------- |
| `<leader>?` | 普通 | `which-key.show({global=false})` | 查看当前缓冲区快捷键 | which-key |

---

## Treesitter 导航

| 快捷键       | 模式             | 命令                                          | 说明               | 来源                    |
| ------------ | ---------------- | --------------------------------------------- | ------------------ | ----------------------- |
| `<leader>[c` | 普通             | `treesitter-context.go_to_context()`          | 跳到上一个上下文   | nvim-treesitter-context |
| `<leader>]m` | 普通/可视/操作符 | `move.goto_next_end("@function.outer")`       | 跳到下一个函数结尾 | nvim-treesitter         |
| `<leader>[m` | 普通/可视/操作符 | `move.goto_previous_start("@function.outer")` | 跳到上一个函数开头 | nvim-treesitter         |

---

> **提示**: 使用 `<leader>?` 可随时查看当前上下文中所有可用的快捷键。

