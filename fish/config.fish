if status is-interactive
    # Commands to run in interactive sessions can go here

    # Aliases
    abbr y yazi
    abbr n nvim
    abbr vi nvim
    abbr lg lazygit
    abbr cat bat
    abbr ls "lsd --long"
    abbr lt "lsd --long --tree --depth 1"
    abbr delta "delta --side-by-side"
    abbr du "dust --reverse"
    abbr time "hyperfine"

    abbr ci "cargo install"

    # Proxy toggle (current shell session only)
    abbr proxy "set -gx http_proxy http://127.0.0.1:8118; set -gx https_proxy http://127.0.0.1:8118; set -gx all_proxy socks5://127.0.0.1:55558; set -gx HTTP_PROXY \$http_proxy; set -gx HTTPS_PROXY \$https_proxy; set -gx ALL_PROXY \$all_proxy; echo 'Proxy enabled'"
    abbr unproxy "set -e http_proxy; set -e https_proxy; set -e all_proxy; set -e HTTP_PROXY; set -e HTTPS_PROXY; set -e ALL_PROXY; echo 'Proxy disabled'"
end


fish_add_path -pg $HOME/.cargo/bin
fish_add_path -ag $HOME/.local/bin

fastfetch --config examples/25
