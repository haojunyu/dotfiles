if status is-interactive
# Commands to run in interactive sessions can go here
end


fish_add_path -pg $HOME/.cargo/bin
fish_add_path -ag $HOME/.local/bin

fastfetch --config examples/25
