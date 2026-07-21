# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a dotfiles repository managed by [Dotter](https://github.com/SuperCuber/dotter), a dotfile manager and templater written in Rust. The Dotter source code lives in the sibling repo at `/mnt/coder/repos/dotter`.

## How Dotter Works

Dotter deploys dotfiles from this repo to their target locations (typically `~`) via symlinks or templated copies. It reads two configuration files in `.dotter/`:

- **`.dotter/global.toml`** — Defines packages (groups of files) with their source→target mappings, variables, and helper scripts. Packages can declare dependencies on other packages.
- **`.dotter/local.toml`** — Machine-specific config. Selects which packages to enable, and can override files/variables for the local machine. If `local.toml` is missing, Dotter looks for `<hostname>.toml` instead.

## Tooling: committed binary vs. source

Everyday deploys use the **committed prebuilt binary** `./dotter` (alongside `dotter.arm` and `dotter.exe` for other arches/OSes). Do not rebuild from source for normal work — the `cargo` commands in the *Dotter Source* section below are only for hacking on Dotter itself in the sibling repo, then copying the new binary over `./dotter`.

## Common Commands

```bash
# Deploy all dotfiles (default action)
./dotter deploy

# Dry-run: show what would change without actually changing anything
./dotter --dry-run

# Force overwrite of unexpected target files
./dotter --force

# Undeploy: remove all deployed files from target locations
./dotter undeploy

# Watch for changes and auto-deploy
./dotter watch

# Initialize a new dotfiles repo with dummy config
./dotter init
```

## Configuration Structure

- **Packages** are defined in `global.toml` under `[<package_name>]` sections. Each package has `files` (source→target mappings) and `variables` (Handlebars template variables).
- **File targets** can be:
  - **Automatic** (bare string): Dotter auto-detects whether to symlink or template based on file content.
  - **Symbolic** (`type = "symbolic"`): Always symlinked.
  - **Template** (`type = "template"`): Rendered via Handlebars with variable substitution.
- **`exclude`**: A file entry can list glob patterns to skip when the source is a directory (e.g. `nvim = { target = "~/.config/nvim", type = "symbolic", exclude = ["*.md"] }`).
- **Conditions**: Files can have an `if` field with a Handlebars expression — the file is only deployed when the condition is true (e.g. `if = "dotter.linux"`).

## Packages

Packages are defined in `global.toml`. The current graph:

- **`shell`** — base package. Deploys the dotter binaries themselves, SSH config, gitconfig, and tool configs (starship, yazi, pip, uv, npm, cargo). Declares the variable placeholders (`HOME_USER`, `GFW_*`/`ALI_*`/`TX_*`/`RASP_*`/`NAS_*`/`WS_*` host+port pairs, `GIT_NAME`, `GIT_EMAIL`).
- **`fish`**, **`ghostty`** — each `depends = ["shell"]`; symlink their config dirs into `~/.config/`.
- **`keyd`** — `depends = ["shell"]`, `if = "dotter.linux"`, targets the **system path** `/etc/keyd/default.conf` (needs privileges to deploy).

Enabled packages are selected in `local.toml` (`packages = [...]`). `[settings]` sets `default_target_type = "automatic"`.

## `local.toml` and the new-machine workflow

`local.toml` is **gitignored** (see `.gitignore`, along with `.dotter/cache*`). It holds machine-specific values: the package selection plus the real values for every variable declared as an empty placeholder in `global.toml`. On a new machine, create `.dotter/local.toml` (or `.dotter/<hostname>.toml`) and fill in `HOME_USER`, the host/port pairs, and `GIT_NAME`/`GIT_EMAIL` before deploying.
- **`dotter` built-in variables** available in templates: `dotter.os`, `dotter.hostname`, `dotter.packages.<name>`, `dotter.files.<source>`, `dotter.unix`, `dotter.windows`, `dotter.linux`, `dotter.macos`, `dotter.current_dir`.
- **Custom Handlebars helpers**: `math`, `include_template`, `is_executable`, `command_success`, `command_output`.

## Cache

Dotter maintains a cache in `.dotter/cache.toml` and `.dotter/cache/` to track what was deployed. The cache is critical for `undeploy` — without it, Dotter cannot know what to clean up.

## Dotter Source (sibling repo)

The Dotter tool source is at `/mnt/coder/repos/dotter`. It's a Rust project:

```bash
cd /mnt/coder/repos/dotter
cargo build              # Build (debug)
cargo build --release    # Build (optimized, stripped, LTO)
cargo test               # Run all tests
cargo test -p dotter     # Run tests for the dotter crate
cargo clippy             # Lint
```

Key source files:
- `main.rs` — Entry point, CLI dispatch, logging setup
- `args.rs` — Clap argument definitions (`Options` struct, `Action` enum)
- `config.rs` — Configuration loading, merging (global + local + includes + patch), package dependency resolution, directory expansion, file target types
- `deploy.rs` — Core deploy/undeploy logic: loads config, runs hooks, dispatches to actions, manages cache
- `actions.rs` — Individual create/delete/update operations for symlinks and templates, with force/dry-run handling
- `filesystem.rs` — Abstracted filesystem operations (trait `Filesystem` with `RealFilesystem` [unix/windows], `DryRunFilesystem`, and `MockFilesystem` for tests)
- `handlebars_helpers.rs` — Handlebars setup, custom helpers (`math`, `include_template`, `is_executable`, `command_success`, `command_output`), condition evaluation, `dotter.*` built-in variables
- `hooks.rs` — Pre/post deploy/undeploy hook scripts (rendered as templates, then executed)
- `difference.rs` — Diff generation and pretty-printing for template changes
- `init.rs` — `dotter init` implementation
- `watch.rs` — `dotter watch` using watchexec for filesystem monitoring

Feature flags in `Cargo.toml`:
- `scripting` (default): Enables Handlebars `script_helper` — registering Rhai script files as Handlebars helpers.
- `watch` (default): Enables the `dotter watch` subcommand via watchexec.
