# Environment variables & PATH setup.
#
# fish sources conf.d/*.fish in alphabetical order BEFORE config.fish.
# The tool-init files in this directory (atuin/fnm/starship/zoxide/rustup)
# depend on CARGO_HOME being set and on cargo's bin dir being in PATH.
# Naming this file 00-* makes it run first, so those inits find their
# binaries instead of erroring with "expanded command was empty" /
# "command not found".

# On Linux these live under /mnt/ubuntu/ (disk space); on macOS under $HOME.
switch (uname -s)
    case Linux
        set -gx CARGO_HOME /mnt/ubuntu/rust/cargo
        set -gx RUSTUP_HOME /mnt/ubuntu/rust/rustup
        set -gx FNM_DIR /mnt/ubuntu/fnm
    case '*'
        set -gx CARGO_HOME $HOME/.cargo
        set -gx RUSTUP_HOME $HOME/.rustup
        set -gx FNM_DIR $HOME/.fnm
        set -gx JAVA_HOME $(/usr/libexec/java_home -v 21)
end

fish_add_path -pg $CARGO_HOME/bin
fish_add_path -ag $HOME/.local/bin

set -gx TOOL_HOME /mnt/coder/Service/command-line-tools
fish_add_path -ag $TOOL_HOME/bin
fish_add_path -ag $TOOL_HOME/sdk/default/openharmony/toolchains
