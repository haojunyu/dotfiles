if status is-interactive
    # Commands to run in interactive sessions can go here

    # Aliases
    abbr y yazi
    abbr n nvim
    abbr vi nvim
    abbr lg lazygit
    abbr cat bat
    abbr ls "lsd --long"
    abbr delta "delta --side-by-side"
    abbr du "dust --reverse"
    abbr time "hyperfine"

    abbr ci "cargo install"
end


fish_add_path -pg $HOME/.cargo/bin
fish_add_path -ag $HOME/.local/bin

fastfetch --config examples/25
