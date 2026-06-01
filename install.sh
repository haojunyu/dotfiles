#!/bin/bash
set -euo pipefail

# ============================================================
# Ubuntu 26.04 Dev Environment Setup
# ============================================================
# Usage:
#   ./install.sh              - Show this help message
#   ./install.sh all          - Run all install steps
#   ./install.sh <command...> - Run specific install step(s)
#
# Available commands:
#   fish      Install Fish shell (includes apt mirror setup)
#   rust      Install Rust toolchain with Chinese mirrors
#   utils     Install TUI tools (git, fzf, starship, atuin, lsd, bat, zoxide, zellij, etc.)
#   env       Install Node.js (fnm) and Python (uv) toolchains
#   input     Install fcitx5 Chinese input method
# ============================================================

# ── 0. 前置: 切换国内软件源 ──────────────────────────────────
switch_mirror() {
    echo "==> Switching to Aliyun mirror for apt sources..."
    sudo cp /etc/apt/sources.list.d/ubuntu.sources /etc/apt/sources.list.d/ubuntu.sources.bak 2>/dev/null || true
    sudo sed -i \
      's|http://.*archive.ubuntu.com/ubuntu|https://mirrors.aliyun.com/ubuntu|g;
       s|http://security.ubuntu.com/ubuntu|https://mirrors.aliyun.com/ubuntu|g' \
      /etc/apt/sources.list.d/ubuntu.sources
    sudo apt-add-repository ppa:fish-shell/release-4
    sudo apt update
    echo "    Done."
}

# ── 1. Fish Shell ────────────────────────────────────────────
install_fish() {
    echo "==> [fish] Installing Fish shell..."
    sudo apt install -y fish
    if ! grep -q "$(which fish)" /etc/shells; then
        sudo sh -c "echo $(which fish) >> /etc/shells"
    fi
    chsh -s "$(which fish)"
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
    echo "==> [utils] Installing utility tools..."
    sudo apt install -y git lazygit fzf fd-find ripgrep ffmpeg jq resvg imagemagick neovim

    mkdir -p ~/.config/fish/completions
    fdfind --gen-completions fish > ~/.config/fish/completions/fd.fish 2>/dev/null || true

    echo "    APT utils installed. Installing Rust-based tools via cargo..."
    export PATH="$HOME/.cargo/bin:$PATH"

    cargo install starship
    mkdir -p ~/.config/fish/conf.d
    echo '"$HOME/.cargo/bin/starship init fish | source"' > ~/.config/fish/conf.d/starship.fish
    starship preset catppuccin-powerline -o ~/.config/starship.toml

    cargo install atuin

    cargo install tlrc
    fish -c "set -Ux TLDR_LANGUAGE zh"

    cargo install lsd
    cargo install bat
    cargo install zoxide
    cargo install zellij

    # 尝试用snap安装yazi
    sudo snap install yazi --classic

    echo "    All cargo utils installed."
}

# ── 4. Env (Node.js / Python via cargo tools) ───────────────
install_env() {
    echo "==> [env] Installing Node.js and Python toolchains..."
    export PATH="$HOME/.cargo/bin:$PATH"

    cargo install fnm
    fish -c "fnm install --lts"
    npm config set registry https://registry.npmmirror.com

    cargo install uv
    fish -c "set -Ux UV_INDEX_URL https://mirrors.aliyun.com/pypi/simple"

    echo "    Env toolchains installed."
}

# ── 5. fcitx5 Chinese Input Method ────────────────────────────
install_input() {
    echo "==> [input] Installing fcitx5 Chinese input method..."
    sudo apt install -y language-pack-zh-hans fcitx5 fcitx5-chinese-addons

    # 1. Specify fcitx5 as default input method
    im-config -n fcitx5

    # 2. Write env vars for compatibility
    cat << 'PROFILE_EOF' >> ~/.profile
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export SDL_IM_MODULE=fcitx
PROFILE_EOF

    cat << 'XPROFILE_EOF' >> ~/.xprofile
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export SDL_IM_MODULE=fcitx
XPROFILE_EOF

    # 3. Set fcitx5 autostart
    mkdir -p ~/.config/autostart
    cp /usr/share/applications/org.fcitx.Fcitx5.desktop ~/.config/autostart/ 2>/dev/null || true

    echo "    fcitx5 installed. Re-login or reboot to take effect."
}

# ── Help ─────────────────────────────────────────────────────
show_help() {
    cat << 'EOF'
Ubuntu 26.04 Dev Environment Setup

Usage:
  ./install.sh              Show this help message
  ./install.sh all          Run all install steps
  ./install.sh <command...> Run specific install step(s)

Available commands:
  fish      Install Fish shell (includes apt mirror setup)
  rust      Install Rust toolchain with Chinese mirrors
  utils     Install TUI tools (git, fzf, starship, atuin, lsd, bat, zoxide, zellij, etc.)
  env       Install Node.js (fnm) and Python (uv) toolchains
  input     Install fcitx5 Chinese input method

Examples:
  ./install.sh fish         # Install Fish shell only
  ./install.sh rust utils   # Install Rust + utils
EOF
}

# ── Main ─────────────────────────────────────────────────────
run_all() {
    echo ""
    echo "╔══════════════════════════════════════════════════════╗"
    echo "║  Ubuntu 26.04 Dev Environment Setup                  ║"
    echo "║  Running all install steps...                        ║"
    echo "╚══════════════════════════════════════════════════════╝"
    echo ""
    switch_mirror
    install_fish
    install_input
    install_rust
    install_utils
    install_env
    echo ""
    echo "╔══════════════════════════════════════════════════════╗"
    echo "║  Done!                                               ║"
    echo "║  Remember to re-login for fish / fcitx5 to take effect. ║"
    echo "╚══════════════════════════════════════════════════════╝"
}

if [ $# -eq 0 ] || [ "$1" = "help" ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    show_help
else
    echo ""
    echo "╔══════════════════════════════════════════════════════╗"
    echo "║  Selective Install                                   ║"
    echo "╚══════════════════════════════════════════════════════╝"
    echo ""

    # Run switch_mirror once if any selected command needs apt
    for arg in "$@"; do
        case "$arg" in
            fish|utils|input) switch_mirror; break ;;
        esac
    done

    for arg in "$@"; do
        case "$arg" in
            all)   run_all ;;
            fish)  install_fish ;;
            rust)  install_rust ;;
            utils) install_utils ;;
            env)   install_env ;;
            input) install_input ;;
            *)
                echo "  Unknown command: $arg"
                echo "  Run './install.sh help' for available commands."
                exit 1
                ;;
        esac
    done

    echo ""
    echo "╔══════════════════════════════════════════════════════╗"
    echo "║  Done!                                               ║"
    echo "╚══════════════════════════════════════════════════════╝"
fi
