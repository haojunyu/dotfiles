# dotfiles


## dotter 变量

变量在 `.dotter/global.toml` 的 `[shell.variables]` 中以空占位符声明，实际值填在 gitignored 的 `.dotter/local.toml`（或 `.dotter/<hostname>.toml`）里，供 `ssh_config` / `gitconfig` 等模板渲染使用。

| 变量 | 必填 | 用途 |
|---|---|---|
| `HOME_USER` | ✅ | 所有远程主机的 SSH 登录用户名（`User` 字段） |
| `GFW_HOST` / `GFW_PORT` | 可选 | 海外 VPS，渲染 `Host gfw` 和 `Host bwg` 两个别名 |
| `ALI_HOST` / `ALI_PORT` | 可选 | 阿里云服务器，渲染 `Host ali` |
| `TX_HOST` / `TX_PORT` | 可选 | 腾讯云服务器，渲染 `Host tx` |
| `RASP_HOST` / `RASP_PORT` | 可选 | 树莓派，渲染 `Host rasp` |
| `NAS_HOST` / `NAS_PORT` | 可选 | NAS，渲染 `Host nas` |
| `WS_HOST` / `WS_PORT` | 可选 | WSL 工作机，渲染 `Host ws`（登录后自动 `cd /mnt/coder` 并进入 fish） |
| `GIT_NAME` / `GIT_EMAIL` | 可选 | `~/.gitconfig` 的 `user.name` / `user.email` |

说明：

- 所有 host/port 变量对都在模板里用 `{{#if (and XXX_HOST XXX_PORT)}}` 守卫——留空则对应 SSH `Host` 段整个跳过，不会渲染出残缺配置；`GIT_NAME`/`GIT_EMAIL` 同理（两者都填才写入 `[user]` 段）
- 所有远程主机统一使用 `~/.ssh/id_ed25519` 密钥登录
- 新机器流程：创建 `.dotter/local.toml` → 填 `HOME_USER` 及各 host/port、git 信息 → `./dotter deploy`

## 个性化配置

所有个性化配置均由 dotter 部署（`./dotter deploy`），安装脚本（`scripts/mac_install.sh` / `scripts/ubuntu_install.sh`）只负责安装软件本身，不再直接写任何配置文件。映射关系定义在 `.dotter/global.toml`，机器专属变量在 `.dotter/local.toml`（gitignored）。

各软件的配置文件与生成逻辑如下：

### Rust / cargo

- 仓库文件：`cargo_config.toml` → `~/.cargo/config.toml`（symbolic）
- 内容：crates.io 替换为国内镜像源（默认 aliyun sparse，另备 ustc / sjtu / tuna / rustcc）
- 生成逻辑：手工维护；rustup 本体由安装脚本通过 `RUSTUP_DIST_SERVER` / `RUSTUP_UPDATE_ROOT` 镜像环境变量安装

### starship

- 仓库文件：`config_starship.toml` → `~/.config/starship.toml`（symbolic）
- fish 侧初始化：`fish/conf.d/starship.fish`（`starship init fish | source`，带 `command -q starship` 守卫）
- 生成逻辑：由官方 preset 生成，可用以下命令重新生成：
  ```bash
  starship preset catppuccin-powerline -o config_starship.toml
  ```

### fish

- 仓库文件：`fish/` 整个目录 → `~/.config/fish`（symbolic）
- 结构：`config.fish`、`fish_variables`、`conf.d/`（00-env、atuin、fnm、fzf、starship、tlrc、zoxide 等按字母序加载）、`completions/`
- 生成逻辑：手工维护；`conf.d/00-env.fish` 负责 PATH / CARGO_HOME / FNM_DIR 等环境变量，须最先加载（注意其中含 WSL 专用路径，mac 上使用时需确认）

### tlrc (tldr)

- 配置文件：`fish/conf.d/tlrc.fish`
- 内容：`TLDR_LANGUAGE=zh`（带 `command -q tldr` 守卫）
- 生成逻辑：手工维护；取代了原安装脚本中的 `fish -c "set -Ux TLDR_LANGUAGE zh"` universal variable 方式

### fd

- 配置文件：`fish/completions/fd.fish`
- 生成逻辑：由 fd 自带命令生成，升级 fd 后可重新生成：
  ```bash
  fd --gen-completions fish > fish/completions/fd.fish
  ```

### Node.js (fnm / npm)

- 仓库文件：`npmrc` → `~/.npmrc`（symbolic）
- 内容：npm registry 指向 `https://registry.npmmirror.com`
- 生成逻辑：手工维护；Node 本体由安装脚本 `cargo install fnm && fnm install --lts` 安装，fish 侧初始化在 `fish/conf.d/fnm.fish`

### Python (uv)

- 仓库文件：`config_uv_uv.toml` → `~/.config/uv/uv.toml`（symbolic）
- 内容：默认 index 指向 aliyun pypi 镜像（`https://mirrors.aliyun.com/pypi/simple`）
- 生成逻辑：手工维护；uv 本体由安装脚本 `cargo install uv` 安装（取代了原 `set -Ux UV_INDEX_URL` universal variable 方式）

## agent 安装

```bash
npm install -g @anthropic-ai/claude-code
npm install -g @earendil-works/pi-coding-agent
```
