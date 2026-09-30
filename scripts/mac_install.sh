#!/bin/bash
set -euo pipefail

# ============================================================
# macOS Dev Environment Setup
# ============================================================
# This script ONLY installs software. All dotfile/config setup
# (cargo mirrors, starship, fish, npmrc, uv, ...) is handled by
# dotter: create .dotter/local.toml, then run ./dotter deploy.
#
# Usage:
#   ./mac_install.sh              - Show this help message
#   ./mac_install.sh all          - Run all install steps
#   ./mac_install.sh <command...> - Run specific install step(s)
#
# Available commands:
#   brew      Install Xcode CLI tools and Homebrew (TUNA mirrors)
#   zsh       Install Zsh shell and set it as default
#   fish      Install Fish shell and set it as default
#   rust      Install Rust toolchain with Chinese mirrors
#   utils     Install TUI tools (git, fzf, starship, atuin, lsd, bat, zoxide, zellij, etc.)
#   env       Install Node.js (fnm) and Python (uv) toolchains
# ============================================================

# ── 0. 前置: Xcode 命令行工具和 Homebrew ────────────────────────────
setup_brew() {
    echo "==> Installing Xcode CLI tools and Homebrew (TUNA mirrors)..."
    xcode-select --install || true
    export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
    export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
    export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
    if ! command -v brew &> /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    # Apple Silicon: /opt/homebrew, Intel: /usr/local
    eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || brew shellenv)"
    echo "    Done."
}

# ── 1a. Zsh Shell ────────────────────────────────────────────
install_zsh() {
    echo "==> [zsh] Installing Zsh shell..."
    brew install zsh
    local zsh_path
    zsh_path="$(brew --prefix)/bin/zsh"
    if ! grep -q "$zsh_path" /etc/shells; then
        sudo sh -c "echo $zsh_path >> /etc/shells"
    fi
    chsh -s "$zsh_path"
    echo "    Zsh installed. Logout and login to take effect."
}

# ── 1b. Fish Shell ───────────────────────────────────────────
install_fish() {
    echo "==> [fish] Installing Fish shell..."
    brew install fish
    local fish_path
    fish_path="$(brew --prefix)/bin/fish"
    if ! grep -q "$fish_path" /etc/shells; then
        sudo sh -c "echo $fish_path >> /etc/shells"
    fi
    chsh -s "$fish_path"
    echo "    Fish installed. Logout and login to take effect."
}

# ── 2. Rust (with mirrors) ──────────────────────────────────
install_rust() {
    echo "==> [rust] Installing Rust toolchain..."
    export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
    export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    mkdir -p ~/.cargo
    cat > ~/.cargo/config.toml << 'CARGO_EOF'
[source.crates-io]
replace-with = 'aliyun'

[source.aliyun]
registry = "sparse+https://mirrors.aliyun.com/crates.io-index/"
[source.ustc]
registry = "https://mirrors.ustc.edu.cn/crates.io-index"
[source.sjtu]
registry = "https://mirrors.sjtug.sjtu.edu.cn/git/crates.io-index/"
[source.tuna]
registry = "https://mirrors.tuna.tsinghua.edu.cn/git/crates.io-index.git"
[source.rustcc]
registry = "https://code.aliyun.com/rustcc/crates.io-index.git"
CARGO_EOF
    echo "    Rust installed. Restart shell or run: source ~/.cargo/env"
}

# ── 3. Utils (TUI tools + git + system utils) ────────────────
install_utils() {
    echo "==> [utils] Installing utility tools via brew..."
    brew install git lazygit fzf ffmpeg jq resvg imagemagick gh

    # starship.toml / fish conf.d & completions are deployed by dotter.
    cargo install starship
    cargo install --locked atuin
    cargo install tlrc
    cargo install lsd               # ls
    cargo install zoxide            # cd
    cargo install bat               # cat
    cargo install ripgrep           # grep  -> rg
    cargo install fd-find           # find  -> fd
    cargo install git-delta         # diff  -> delta
    cargo install hyperfine         # time
    cargo install dust-du           # du -> dust
    cargo install sd                # sed
    cargo install zellij
    cargo install tree-sitter-cli

    # yazi, nvim(0.12) via brew
    brew install yazi neovim

    echo "    All utils installed."
}

# ── 4. Env (Node.js / Python via cargo tools) ───────────────
install_env() {
    echo "==> [env] Installing Node.js and Python toolchains..."
    export PATH="$HOME/.cargo/bin:$PATH"

    # 在 mac 中使用 brew 进行 node 的安装和管理，而不用 fnm
    brew install node
    npm config set registry https://registry.npmmirror.com

    cargo install uv
    uv pip config set global.index-url https://mirrors.aliyun.com/pypi/simple

    echo "    Env toolchains installed."
}

# ── Help ─────────────────────────────────────────────────────
show_help() {
    cat << 'EOF'
macOS Dev Environment Setup

This script ONLY installs software. Dotfile/config deployment is
handled by dotter (see the reminder printed at the end).

Usage:
  ./mac_install.sh              Show this help message
  ./mac_install.sh all          Run all install steps (default shell: zsh)
  ./mac_install.sh <command...> Run specific install step(s)

Available commands:
  brew      Install Xcode CLI tools and Homebrew (TUNA mirrors)
  zsh       Install Zsh shell and set it as default
  fish      Install Fish shell and set it as default
  rust      Install Rust toolchain with Chinese mirrors
  utils     Install TUI tools (git, fzf, starship, atuin, lsd, bat, zoxide, zellij, etc.)
  env       Install Node.js (fnm) and Python (uv) toolchains

Examples:
  ./mac_install.sh fish         # Install Fish shell only
  ./mac_install.sh rust utils   # Install Rust + utils
EOF
}

# ── Main ─────────────────────────────────────────────────────
show_dotter_reminder() {
    echo ""
    echo "╔══════════════════════════════════════════════════════╗"
    echo "║  Software installed. Next: deploy dotfiles via       ║"
    echo "║  dotter from the repo root:                          ║"
    echo "║                                                      ║"
    echo "║    1. Create .dotter/local.toml and fill in          ║"
    echo "║       HOME_USER, host/port pairs, GIT_NAME/EMAIL     ║"
    echo "║    2. ./dotter deploy                                ║"
    echo "╚══════════════════════════════════════════════════════╝"
}

run_all() {
    echo ""
    echo "╔══════════════════════════════════════════════════════╗"
    echo "║  macOS Dev Environment Setup                         ║"
    echo "║  Running all install steps...                        ║"
    echo "╚══════════════════════════════════════════════════════╝"
    echo ""
    setup_brew
    install_zsh
    install_rust
    install_utils
    install_env
    echo ""
    echo "╔══════════════════════════════════════════════════════╗"
    echo "║  Done!                                               ║"
    echo "║  Remember to re-login for zsh to take effect.        ║"
    echo "╚══════════════════════════════════════════════════════╝"
    show_dotter_reminder
}

if [ $# -eq 0 ] || [ "$1" = "help" ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    show_help
else
    echo ""
    echo "╔══════════════════════════════════════════════════════╗"
    echo "║  Selective Install                                   ║"
    echo "╚══════════════════════════════════════════════════════╝"
    echo ""

    # Run setup_brew once if any selected command needs brew
    for arg in "$@"; do
        case "$arg" in
            zsh|fish|utils) setup_brew; break ;;
        esac
    done

    for arg in "$@"; do
        case "$arg" in
            all)   run_all ;;
            brew)  setup_brew ;;
            zsh)   install_zsh ;;
            fish)  install_fish ;;
            rust)  install_rust ;;
            utils) install_utils ;;
            env)   install_env ;;
            *)
                echo "  Unknown command: $arg"
                echo "  Run './mac_install.sh help' for available commands."
                exit 1
                ;;
        esac
    done

    echo ""
    echo "╔══════════════════════════════════════════════════════╗"
    echo "║  Done!                                               ║"
    echo "╚══════════════════════════════════════════════════════╝"
    show_dotter_reminder
fi
